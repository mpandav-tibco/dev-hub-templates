#!/bin/bash

#######################################################################################################################
#   This script is used to trigger a Jenkins pipeline to build a TIBCO BusinessWorks                                  #
#   Container Edition (BWCE) application. The script performs the following steps:                                    #
#   1. Clone the Git repository                                                                                       #
#   2. Build the application EAR using Maven                                                                          #
#   3. Build the Docker image                                                                                         #
#   4. Update the deployment YAML                                                                                     #
#   5. Update the Git repository                                                                                      #
#   6. Deploy to Kubernetes or TIBCO Platform (conditional)                                                           #
#                                                                                                                     #
#   The script requires the following environment variables to be set:                                                #
#   - repo_host: The Git repository host (e.g., github.com)                                                           #
#   - repo_owner: The Git repository owner (e.g., tibco)                                                              #
#   - repo_name: The Git repository name (e.g., bwce-sample)                                                          #
#   - bw_project_folder: The BWCE project folder name (e.g., BWCE-Sample)                                             #
#   - namespace: The Kubernetes namespace (e.g., default)                                                             #
#   - platformToken: The TIBCO Platform token                                                                         #
#   - dpUrl: The TIBCO Platform URL (e.g., https://cloud.tibco.com)                                                   #
#   - deployTarget: The deployment target (K8S or TIBCO Platform)                                                     #
#   - deploy: The deployment flag (true or false)                                                                     #
#                                                                                                                     #
#   The script also requires the following tools to be installed:                                                     #
#   - git                                                                                                             #
#   - tree                                                                                                            #
#   - yq                                                                                                              #
#   - docker                                                                                                          #
#   - kubectl                                                                                                         #
#   - mvn                                                                                                             #
#                                                                                                                     #
#   The script uses the following environment variables to set Jenkins build parameters:                              #
#   - repoHost                                                                                                        #
#   - repoOwner                                                                                                       #
#   - repoName                                                                                                        #
#   - projectName                                                                                                     #
#   - k8s_namespace                                                                                                   #
#   - platformToken                                                                                                   #
#   - dpUrl                                                                                                           #
#   - deployTarget                                                                                                    #
#   - deploy                                                                                                          #
#                                                                                                                     #
#   The script uses the following environment variables to set the Docker image name:                                 #
#   - IMAGE                                                                                                           #
#                                                                                                                     #
#   The script uses the following environment variables to set the Kubernetes deployment name:                        #
#   - repoName                                                                                                        #
#                                                                                                                     #
#   The script uses the following environment variables to set the TIBCO Platform deployment parameters:              #
#   - BASE_VERSION                                                                                                    #
#   - BASE_IMAGE_TAG                                                                                                  #
#                                                                                                                     #
#######################################################################################################################

# Set Jenkins build parameters
export repoHost="$repo_host"
export repoOwner="$repo_owner"
export repoName="$repo_name"
export projectName=$(echo "$bw_project_folder" | tr '[:upper:]' '[:lower:]')
export k8s_namespace="$namespace"
export platformToken="$platformToken"
export dpUrl="$dpUrl"
export deployTarget="$deployTarget"
export deploy="$deploy"

# Remove any existing directory with the same name (except the .git directory)
rm -rf *

# Function to clone the Git repository
clone_repo() {
  echo -----------------------------------------------------------
  echo "STEP 1: Clone the repo: https://$repoHost/$repoOwner/$repoName.git"
  echo -----------------------------------------------------------

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
    echo "ERROR: Could not find the xxxx.xxx.parent directory."
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

  # Show folder structure: before docker build
  tree -L 2

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

}

# Function to update the deployment YAML
update_deployment_yaml() {

  # start from base directory
  cd ../"$repoName" || exit 1

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
  git add build-artifacts deployment.yaml
  git commit -m "Add build-artifacts and updated deployment.yaml"
  git push
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
    echo "ERROR: Could not find the $repoName.parent directory."
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

echo -----------------------------------------------------------
echo "                 BUILD COMPLETE"
echo -----------------------------------------------------------
