##############################################################################
#                                       #                                    #   
#               JENKINS BUILD SCRIPT FOR BWCE APPLICATION                    #
#                                       #                                    #  
##############################################################################

export repoHost=$repo_host
export repoOwner=$repo_owner
export repoName=$repo_name
export projectName=$(echo "$bw_project_folder" | tr '[:upper:]' '[:lower:]') 

echo -----------------------------------------------------------
echo       STEP 1: Clone the repo : https://$repoHost/$repoOwner/$repoName.git
echo -----------------------------------------------------------

# Remove any existing directory with the same name
rm -rf *

# Clone the repository
git clone https://$repoHost/$repoOwner/$repoName.git

# Print the repository URL
echo --- url: "https://$repoHost/$repoOwner/$repoName.git"

echo -----------------------------------------------------------
echo      $repoName.git FILE STRUCTURE
echo -----------------------------------------------------------

# Show folder structure : Show the first two levels of the directory structure
tree -L 2  

echo -----------------------------------------------------------
echo        STEP 2: Maven - BUILD APPLICATION EAR
echo -----------------------------------------------------------

# Find the xxxx.xxx.parent directory (adjust the pattern if needed)
parent_dir=$(find $repoName -type d -name "*.parent" -print -quit)

if [ -z "$parent_dir" ]; then
  echo "ERROR: Could not find the xxxx.xxx.parent directory."
  exit 1
fi

# Navigate to the parent directory
cd "$parent_dir"

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

# Print the path to the .ear file (optional)
echo "EAR file moved to: ../build-artifacts/"

# Show folder structure : after maven package
tree -L 2  

echo -----------------------------------------------------------
echo            STEP 3: DOCKER BUILD 
echo -----------------------------------------------------------

cd build-artifacts/
# Find the .ear file recursively in the workspace
ear_file=$(find . -name "*.ear" -print -quit)

# Create the Dockerfile
cat > Dockerfile << EOF
FROM mpandav/bwce-291-rst:base
LABEL maintainer=" mpandav"
ADD $ear_file /
EOF

# Show folder structure : before docker build
tree -L 2  

echo DOCKER FILE IN USE

echo -----------------------------------------------------------
cat Dockerfile
echo -----------------------------------------------------------

# Build the Docker image
docker build -t $repo_owner/$repo_name .

# Print the Docker image name (optional)
export IMAGE=$repo_owner/$repo_name

echo -----------------------------------------------------------
echo         "Docker image built: $IMAGE "
echo -----------------------------------------------------------


echo -----------------------------------------------------------
echo           STEP 4: K8S DEPLOYMENT PREPARATION
echo -----------------------------------------------------------


# start from base directory
cd ../bwce-demo-4

echo "###### Update the deployment.yaml file with variable substitution (using yq) #######"

# Update the deployment.yaml file with variable substitution (using yq)
yq eval '.metadata.name = strenv(repoName)' deployment.yaml > deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
yq eval '.metadata.labels."backstage.io/kubernetes-id" = strenv(repoName)' deployment.yaml > deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
yq eval '.spec.template.spec.containers[0].name = strenv(projectName) + "-" + strenv(repoName)' deployment.yaml > deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
yq eval '.spec.template.spec.containers[0].image = strenv(IMAGE)' deployment.yaml > deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
yq eval '.spec.template.metadata.labels."backstage.io/kubernetes-id" = strenv(repoName)' deployment.yaml > deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml
yq eval '.metadata.labels.app = (if (strenv(repoName) | length > 0) then strenv(repoName) else "" end)' deployment.yaml > deployment.yaml.tmp && mv deployment.yaml.tmp deployment.yaml

echo "######### DEPLOYMENT.YAML #############"
echo -----------------------------------------------------------
cat deployment.yaml
echo -----------------------------------------------------------


echo -----------------------------------------------------------
echo            STEP 5: GIT UPDATE 
echo -----------------------------------------------------------

# Add, commit, and push changes to the Git repository
git add Dockerfile build-artifacts deployment.yaml
git commit -m "Add Dockerfile, build artifacts, and updated deployment YAML"
git push origin main  # Or your branch name


echo -----------------------------------------------------------
echo            STEP 6: K8S DEPLOYMENT 
echo -----------------------------------------------------------

echo "######### DEPLOY APPLICATION: $repoName TO K8S CLUSTER #############"

# Deploy to Kubernetes and check for errors
if ! kubectl apply -f deployment.yaml; then
  echo "ERROR: Kubernetes deployment failed!"
  exit 1
fi
# Print the status of the deployment
#kubectl rollout status deployment/$repoName -n tibco-apps


echo -----------------------------------------------------------
echo                  BUILD COMPLETE 
echo -----------------------------------------------------------