#!/bin/bash

USER_NAME=${1:?usage: ./deploy.sh <dockerhub-username> [tag] [port]}
TAG=${2:-latest}
PORT=${3:-8093}
IMAGE="$USER_NAME/quotes-api:$TAG"
NAME=quotes-api-deploy

docker pull "$IMAGE" || exit 1
docker rm -f"$NAME" >/dev/null 2>&1
docker run -d --name "$NAME" -p "$PORT:8000" --restart unless-stopped "$IMAGE" || exit 1

for i in 1 2 3 4 5 6 7 8 9 10; do
	if curl -s -o /dev/null -m 2 "http://localhost:$PORT/health"; then
		echo "deployed $IMAGE on port $PORT"
		exit 0
	fi
	sleep 1
done 

echo "deploy failed: $IMAGE did not answer on port $PORT"
docker logs "$NAME"
exit 1
