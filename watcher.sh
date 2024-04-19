# 1. Define Variables: Set the namespace, deployment name, and maximum number of restarts allowed before scaling down the deployment.
NAMESPACE="sre"
DEPLOYMENT_NAME="swype-app"
MAX_RESTARTS=3

# 2. Start a Loop: Begin an infinite loop that will continue until explicitly broken.
while true; do
  # 3. Check Pod Restarts: Within the loop, use the kubectl get pods command to retrieve the number of restarts of the pod associated with the specified deployment in the specified namespace.
  RESTARTS=$(kubectl get pods -n ${NAMESPACE} -l app=${DEPLOYMENT_NAME} -o jsonpath="{.items[0].status.containerStatuses[0].restartCount}")
  # 4. Display Restart Count: Print the current number of restarts to the console.
  echo "Restart Count: ${RESTARTS}"
  # 5. Check Restart Limit: Compare the current number of restarts with the maximum allowed number of restarts.
  if ((RESTARTS > MAX_RESTARTS)); then
    # 6. Scale Down if Necessary: If the number of restarts is greater than the maximum allowed, print a message to the console, scale down the deployment to zero replicas using the kubectl scale command, and break the loop.
    echo "Scaling down"
    kubectl scale --replicas=0 deployment/${DEPLOYMENT_NAME} -n ${NAMESPACE}
    break
  else
    # 7. Pause: If the number of restarts is not greater than the maximum allowed, pause the script for 60 seconds before the next check.
    echo "Sleeping"
    sleep 60
  fi
  # 8. Repeat: After the pause, the script goes back to step 3. This process repeats indefinitely until the number of restarts exceeds the maximum allowed, at which point the deployment is scaled down and the loop is broken.
done
