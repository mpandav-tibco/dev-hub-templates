#!/bin/bash

# Set Jenkins build parameters
repoHost="$repo_host"
repoOwner="$repo_owner"
repoName="$repo_name"
projectName=$(echo "$bw_project_folder" | tr '[:upper:]' '[:lower:]')
k8s_namespace="$namespace"
platformToken="$platformToken"
dpUrl="$dpUrl"
deployTarget="$deployTarget"
deploy="$deploy"

echo $k8s_namespace --- $platformToken --- $dpUrl --- $deployTarget --- $deploy

# Function to clone the Git repository
clone_repo() {
  echo -----------------------------------------------------------
  echo "STEP 1: Clone the repo: https://$repoHost/$repoOwner/$repoName.git"
  echo -----------------------------------------------------------

  # Remove any existing directory with the same name (except the .git directory)
  rm -rf "$repoName"

  # Clone the repository
  git clone "https://$repoHost/$repoOwner/$repoName.git"

  # Print the repository URL
  echo "--- url: https://$repoHost/$repoOwner/$repoName.git"

  echo -----------------------------------------------------------
  echo "$repoName FILE STRUCTURE"
  echo -----------------------------------------------------------

  # Show folder structure: Show the first two levels of the directory structure
  tree -L 2 "$repoName"
}

# Function to build the application EAR using Maven
build_ear() {
  echo -----------------------------------------------------------
  echo "STEP 2: Maven - BUILD APPLICATION EAR"
  echo -----------------------------------------------------------

  # Find the xxxx.xxx.parent directory
  parent_dir=$(find "$repoName" -type d -name "*.parent" -print -quit)

  if [ -z "$parent_dir" ]; then
    echo "ERROR: Could not find the $repoName.application.parent directory."
    exit 1
  fi

  # Navigate to the parent directory
  cd "$parent_dir" || exit 1

  # Run Maven commands
  mvn clean package

  # Move to parent directory
  cd ../../

  # Find the .ear file recursively in the workspace
  ear_file=$(find . -name "*.ear" -print -quit)

  if [ -z "$ear_file" ]; then
    echo "ERROR: Could not find the .ear file."
    exit 1
  fi

  # Create the build-artifacts directory in the base folder
  mkdir -p build-artifacts

  # Move the .ear file to the build-artifacts directory
  mv "$ear_file" build-artifacts/

  # Print the path to the .ear file
  echo "EAR file moved to: build-artifacts/"

  # Show folder structure: after maven package
  tree -L 2
}

# Function to build the Docker image
build_docker_image() {
  echo -----------------------------------------------------------
  echo "STEP 3: DOCKER BUILD"
  echo -----------------------------------------------------------

  cd build-artifacts/ || exit 1

  # Find the .ear file recursively in the workspace
  ear_file=$(find . -name "*.ear" -print -quit)

  # Create the Dockerfile
  cat >Dockerfile <<EOF
FROM mpandav/bwce-291-rst:base
LABEL maintainer="mpandav"
ADD $ear_file /
EOF

  echo "DOCKER FILE IN USE"

  echo -----------------------------------------------------------
  cat Dockerfile
  echo -----------------------------------------------------------

  # Build the Docker image
  docker build -t "$repoOwner/$repoName" .

  # Print the Docker image name
  export IMAGE="$repoOwner/$repoName"

  echo -----------------------------------------------------------
  echo "Docker image built: $IMAGE"
  echo -----------------------------------------------------------

  # start from base directory
  cd ../"$repoName" || exit 1
}

# Function to update the deployment YAML
update_deployment_yaml() {
  echo -----------------------------------------------------------
  echo "STEP 4: K8S DEPLOYMENT PREPARATION"
  echo -----------------------------------------------------------

  echo "###### Update the deployment.yaml file with variable substitution (using yq) #######"

  # Update the deployment.yaml file with variable substitution (using yq)
  yq eval '.metadata.name = env(repoName)' deployment.yaml >deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
  yq eval '.metadata.labels."backstage.io/kubernetes-id" = env(repoName)' deployment.yaml >deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
  yq eval '.spec.template.spec.containers[0].name = env(projectName) + "-" + env(repoName)' deployment.yaml >deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
  yq eval '.spec.template.spec.containers[0].image = env(IMAGE)' deployment.yaml >deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
  yq eval '.spec.template.metadata.labels."backstage.io/kubernetes-id" = env(repoName)' deployment.yaml >deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
  yq eval '.metadata.labels.app = (if (env(repoName) | length > 0) then env(repoName) else "" end)' deployment.yaml >deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml

  echo "######### DEPLOYMENT.YAML #############"
  echo -----------------------------------------------------------
  cat deployment.yaml
  echo -----------------------------------------------------------
}

# Function to update the Git repository
update_git_repo() {
  echo -----------------------------------------------------------
  echo "STEP 5: GIT UPDATE"
  echo -----------------------------------------------------------

  cp -r ../build-artifacts .

  # Add, commit, and push changes to the Git repository
  git add build-artifacts deployment.yaml Dockerfile
  git commit -m "updated deployment.yaml"
  git push origin HEAD
}

# Function to deploy to Kubernetes
deploy_to_k8s() {
  echo "######### DEPLOY APPLICATION: $repoName TO K8S CLUSTER #############"

  # Deploy to Kubernetes and check for errors
  if ! kubectl apply -f deployment.yaml; then
    echo "ERROR: Kubernetes deployment failed!"
    exit 1
  fi
}

# Function to deploy to TIBCO Platform
deploy_to_tibco_platform() {
  echo "######### DEPLOY APPLICATION: $repoName TO TIBCO PLATFORM #############"

  parent_dir=$(find . -type d -name "*.parent" -print -quit)

  if [ -z "$parent_dir" ]; then
    echo "ERROR: Could not find the xxxx.xxx.parent directory."
    exit 1
  fi

  # Navigate to the parent directory
  cd "$parent_dir" || exit 1

  # Run Maven command for TIBCO Platform deployment with error handling
  if ! mvn install -DdpUrl="$dpUrl" -DauthToken="$platformToken" -Dnamespace="$k8s_namespace" -DbaseVersion="$BASE_VERSION" -DbaseImageTag="$BASE_IMAGE_TAG"; then
    echo "ERROR: TIBCO Platform deployment failed!"
    exit 1
  fi
}

# --- Main execution ---

# Clone the repository
clone_repo

# Build the application EAR
build_ear

# Build the Docker image
build_docker_image

# Update the deployment YAML
update_deployment_yaml

# Update the Git repository
update_git_repo

echo -----------------------------------------------------------
echo "           STEP 6: DEPLOYMENT (CONDITIONAL)"
echo -----------------------------------------------------------

# Check if deployment is required
if [ "$deploy" = "true" ]; then
  # Call the appropriate deployment function
  if [ "$deployTarget" = "K8S" ]; then
    deploy_to_k8s
  elif [ "$deployTarget" = "TIBCO Platform" ]; then
    deploy_to_tibco_platform
  else
    echo "ERROR: Invalid deployTarget. Must be 'K8S' or 'TIBCO Platform'."
    exit 1
  fi
else
  echo "##### JENKINS: DEPLOYMENT SKIPPED (deploy parameter is false) #####"
fi

# Show folder structure: before  build completion
tree -L 2
echo -----------------------------------------------------------
echo "                 BUILD COMPLETE"
echo -----------------------------------------------------------
