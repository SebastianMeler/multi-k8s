docker build -t smeler/multi-client:latest -t smeler/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t smeler/multi-server:latest -t smeler/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t smeler/multi-worker:latest -t smeler/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push smeler/multi-client:latest
docker push smeler/multi-server:latest
docker push smeler/multi-worker:latest
docker push smeler/multi-client:$SHA
docker push smeler/multi-server:$SHA
docker push smeler/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=smeler/multi-server:$SHA
kubectl set image deployments/client-deployment client=smeler/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=smeler/multi-worker:$SHA