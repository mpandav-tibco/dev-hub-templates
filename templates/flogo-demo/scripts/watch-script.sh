FlogoSrc=$1
FlogoApp=$2
# TestCall=$3
TestCall="${3:-http://localhost:9999/getData}"
echo "TestCall: $TestCall"

# FlogoSrc="flogo-app-GetData.json"
# FlogoApp="flogo-app-GetData"
# TestCall="http://localhost:9999/getData"

# FlogoSrc="flogo-app-HelloWorld.json"
# FlogoApp="flogo-app-HelloWorld"
# TestCall="http://localhost:9999/hello/world"

# File to store the process ID of the active Flogo App
FlogoPIDFile="FlogoPID.lock"
echo "Watching Flogo File"

if test -f "$FlogoPIDFile"; then
      echo "Killing old Flogo engine"
      source "./$FlogoPIDFile"
      echo "Flogo PID: $FlogoPID"
      kill $FlogoPID
      # Setting the PID to empty
      rm FlogoPID.lock
else
      echo "No old Flogo process to kill..."
fi
"./$FlogoApp" -app "$FlogoSrc" &
export FlogoPID=$!
echo "FlogoPID=$FlogoPID" > "$FlogoPIDFile"
sleep 0.1
echo "Flogo Process ID: $FlogoPID"

# Run a test
curl -X 'GET' "$TestCall" -H 'accept: application/json' > result.json