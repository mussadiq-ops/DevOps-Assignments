#!/bin/bash
# =============================================================
# Docker Task 3 - Complete Setup & Deployment Script
# Custom Nginx Image + Docker Compose with Volume Bind Mount
# =============================================================

set -e  # Exit on any error

# ---- CONFIGURATION (EDIT THESE) ----
DOCKERHUB_USERNAME="your-dockerhub-username"
IMAGE_NAME="custom-nginx"
IMAGE_TAG="latest"
FULL_IMAGE_NAME="${DOCKERHUB_USERNAME}/${IMAGE_NAME}:${IMAGE_TAG}"
VOLUME_PATH="/var/opt/nginx"

echo "=============================================="
echo "  Docker Task 3 - Nginx Custom Image Setup"
echo "=============================================="

# -------------------------------------------------------
# STEP 1: Install Docker on AWS EC2 (Amazon Linux 2 / Ubuntu)
# -------------------------------------------------------
install_docker_amazon_linux() {
    echo ""
    echo ">>> [STEP 1] Installing Docker on Amazon Linux 2..."
    sudo yum update -y
    sudo yum install -y docker
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    echo "Docker installed successfully!"
    docker --version
}

install_docker_ubuntu() {
    echo ""
    echo ">>> [STEP 1] Installing Docker on Ubuntu..."
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
        https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    echo "Docker installed successfully!"
    docker --version
}

# -------------------------------------------------------
# STEP 2: Install Docker Compose
# -------------------------------------------------------
install_docker_compose() {
    echo ""
    echo ">>> [STEP 2] Installing Docker Compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    echo "Docker Compose installed successfully!"
}

# -------------------------------------------------------
# STEP 3: Create Volume Directory on Host
# -------------------------------------------------------
create_volume_directory() {
    echo ""
    echo ">>> [STEP 3] Creating volume bind mount directory at ${VOLUME_PATH}..."
    sudo mkdir -p ${VOLUME_PATH}
    sudo chmod 755 ${VOLUME_PATH}
    sudo chown -R $USER:$USER ${VOLUME_PATH}
    echo "Directory created: ${VOLUME_PATH}"
    ls -la $(dirname ${VOLUME_PATH})
}

# -------------------------------------------------------
# STEP 4: Build the Custom Docker Image
# -------------------------------------------------------
build_docker_image() {
    echo ""
    echo ">>> [STEP 4] Building custom Docker image..."
    docker build -t ${FULL_IMAGE_NAME} .
    echo "Image built successfully: ${FULL_IMAGE_NAME}"
    docker images | grep ${IMAGE_NAME}
}

# -------------------------------------------------------
# STEP 5: Push Image to Docker Hub
# -------------------------------------------------------
push_to_dockerhub() {
    echo ""
    echo ">>> [STEP 5] Pushing image to Docker Hub..."
    echo "Logging into Docker Hub..."
    docker login
    docker push ${FULL_IMAGE_NAME}
    echo "Image pushed successfully to Docker Hub!"
    echo "Image URL: https://hub.docker.com/r/${DOCKERHUB_USERNAME}/${IMAGE_NAME}"
}

# -------------------------------------------------------
# STEP 6: Deploy using Docker Compose
# -------------------------------------------------------
deploy_with_compose() {
    echo ""
    echo ">>> [STEP 6] Deploying with Docker Compose..."

    # Update docker-compose.yml with actual username
    sed -i "s/your-dockerhub-username/${DOCKERHUB_USERNAME}/g" docker-compose.yml

    docker-compose up -d
    echo ""
    echo "Waiting for container to be healthy..."
    sleep 5
    docker-compose ps
}

# -------------------------------------------------------
# STEP 7: Verify Deployment
# -------------------------------------------------------
verify_deployment() {
    echo ""
    echo ">>> [STEP 7] Verifying deployment..."
    echo ""

    echo "=== Container Status ==="
    docker ps --filter name=custom-nginx-container

    echo ""
    echo "=== Container Logs ==="
    docker logs custom-nginx-container --tail=20

    echo ""
    echo "=== Volume Mount Verification ==="
    docker inspect custom-nginx-container | grep -A 10 "Mounts"

    echo ""
    echo "=== Testing HTTP Response ==="
    sleep 3
    curl -s -o /dev/null -w "HTTP Status: %{http_code}\n" http://localhost/
    curl -s -o /dev/null -w "Health Check: %{http_code}\n" http://localhost/health

    echo ""
    echo "=== Volume Directory Contents ==="
    ls -la ${VOLUME_PATH}/

    echo ""
    echo "=============================================="
    echo "  ✅ Deployment Successful!"
    echo "  🌐 Access: http://$(curl -s ifconfig.me)"
    echo "  📁 Volume: ${VOLUME_PATH}"
    echo "  🐳 Image: ${FULL_IMAGE_NAME}"
    echo "=============================================="
}

# -------------------------------------------------------
# STEP 8: Useful Commands Reference
# -------------------------------------------------------
print_commands() {
    echo ""
    echo "=== USEFUL COMMANDS ==="
    echo ""
    echo "# Start services:"
    echo "  docker-compose up -d"
    echo ""
    echo "# Stop services:"
    echo "  docker-compose down"
    echo ""
    echo "# View logs:"
    echo "  docker-compose logs -f"
    echo ""
    echo "# Check container:"
    echo "  docker ps"
    echo "  docker inspect custom-nginx-container"
    echo ""
    echo "# Enter container:"
    echo "  docker exec -it custom-nginx-container bash"
    echo ""
    echo "# Check volume mount:"
    echo "  ls -la /var/opt/nginx/"
    echo "  docker inspect custom-nginx-container | grep -A 10 Mounts"
    echo ""
    echo "# Remove everything:"
    echo "  docker-compose down --rmi all -v"
}

# -------------------------------------------------------
# MAIN EXECUTION
# -------------------------------------------------------
main() {
    # Detect OS and install Docker accordingly
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case $ID in
            amzn)   install_docker_amazon_linux ;;
            ubuntu) install_docker_ubuntu ;;
            *)      echo "Please install Docker manually for your OS: $ID" ;;
        esac
    fi

    install_docker_compose
    create_volume_directory
    build_docker_image
    push_to_dockerhub
    deploy_with_compose
    verify_deployment
    print_commands
}

# Run main function
main "$@"
