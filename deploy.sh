docker build -t robresma/multi-client:latest -t robresma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t robresma/multi-server:latest -t robresma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t robresma/multi-worker:latest -t robresma/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push robresma/multi-client:latest
docker push robresma/multi-server:latest
docker push robresma/multi-worker:latest

docker push robresma/multi-client:$SHA
docker push robresma/multi-server:$SHA
docker push robresma/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=robresma/multi-server:$SHA
kubectl set image deployments/client-deployment client=robresma/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=robresma/multi-worker:$SHA