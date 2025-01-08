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
#   - mvn
#   - Sonarqube
#   - Trivy                                                                                                           #
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
#   - sonar                                                                                                           #
#   - trivy                                                                                                           #
#                                                                                                                     #
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
export sonar="$sonar"
export trivy="$trivy"

# Remove any existing directory with the same name (except the .git directory)
rm -rf *

# Function to clone the Git repository
# Function to clone the Git repository with retry logic
clone_repo() {
  echo -----------------------------------------------------------
  echo "STEP 1: Clone the repo: https://$repoHost/$repoOwner/$repoName.git"
  echo -----------------------------------------------------------

  # Retry loop
  for i in {1..3}; do
    # Clone the repository
    if git clone "https://$repoHost/$repoOwner/$repoName.git"; then
      echo "--- url: https://$repoHost/$repoOwner/$repoName.git"

      echo -----------------------------------------------------------
      echo "$repoName FILE STRUCTURE"
      echo -----------------------------------------------------------

      # Show folder structure: Show the first two levels of the directory structure
      tree -L 2 "$repoName"

      return 0 # Exit the function successfully
    else
      echo "Attempt $i failed. Retrying in 10 seconds..."
      sleep 10
    fi
  done

  echo "ERROR: Failed to clone the repository after 3 attempts."
  exit 1 # Exit the script with an error code
}

# Function to build the application EAR using Maven
build_ear() {
  echo -----------------------------------------------------------
  echo "STEP 2: Maven - BUILD APPLICATION EAR"
  echo -- ---------------------------------------------------------

  cd "$(dirname "$PWD")"

  # Find the xxxx.xxx.parent directory
  parent_dir=$(find "." -type d -name "*.parent" -print -quit)

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
  echo " --- docker build -t $repoOwner/$repoName . "

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

  rm -rf deployment.yaml.tmp

  echo "######### DEPLOYMENT.YAML #############"
  echo -----------------------------------------------------------
  cat deployment.yaml
  echo -----------------------------------------------------------

}

# Function to perform security scan on Image using Trivy
governance_trivy_security_scan() {
  echo -----------------------------------------------------------
  echo "STEP GOVERNANCE: SECURITY SCAN"
  echo -----------------------------------------------------------

  echo "--trivy image --output trivy-security-scan-report.txt  --scanners vuln --severity HIGH,CRITICAL --exit-code 0 $IMAGE"
  # Run the Governance and Security scan
  trivy image --output trivy-security-scan-report.txt  --scanners vuln --severity HIGH,CRITICAL --exit-code 0 "$IMAGE"

  echo "######### GOVERNANCE SECURITY SCAN COMPLETE #############"
}

# Function to perform code scna on repository using SonarQube
governance_sonar_code_scan() {

  echo -----------------------------------------------------------
  echo "STEP GOVERNANCE: CODE SCAN"
  echo -----------------------------------------------------------

  # Find the xxxx.xxx.application directory
  application_dir=$(find "$repoName" -type d -name "*.application" -print -quit)

  if [ -z "$  application_dir=$(find "$repoName" -type d -name "*.application" -print -quit)" ]; then
    echo "ERROR: Could not find the xxxx.xxx.application directory."
    exit 1
  fi

  # Navigate to the parent directory
  cd "$application_dir" || exit 1

  # Run the Governance and Security scan
  mvn sonar:sonar -Dsonar.host.url=$sonarHostUrl -Dsonar.login=$sonarLogin -Dsonar.report.export.path=../sonar-report.txt
  echo " --- mvn sonar:sonar -Dsonar.host.url=$sonarHostUrl -Dsonar.login=$sonarLogin -Dsonar.report.export.path=../sonar-report.txt "
  echo "######### GOVERNANCE CODE SCAN COMPLETE #############"

}

# Function to update the Git repository
update_git_repo() {
  echo -----------------------------------------------------------
  echo "STEP 6: GIT UPDATE"
  echo -----------------------------------------------------------

  cp -r ../build-artifacts .

  # Add, commit, and push changes to the Git repository
  git add build-artifacts deployment.yaml
  git commit -m "Add build-artifacts, trivy-security-scan-report.txt and updated deployment.yaml"
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

# Perform Governance and Code scan
if [ "$sonar" = "true" ]; then
  governance_sonar_code_scan
else
  echo "ERROR: Governance Code scan skipped (sonar parameter is false)."
fi

# Build the application EAR
build_ear

# Build the Docker image
build_docker_image

# Perform Governance and Security scan
if [ "$trivy" = "true" ]; then
  governance_trivy_security_scan
else
  echo "ERROR: Governance and security scan skipped (trivy parameter is false)."
fi

# Update the deployment YAML
update_deployment_yaml

# Update the Git repository
update_git_repo

echo -----------------------------------------------------------
echo "           STEP 7: DEPLOYMENT (CONDITIONAL)"
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
