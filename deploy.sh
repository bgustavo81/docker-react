docker build -t gustavobautista/multi-client:latest -t gustavobautista/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gustavobautista/multi-server:latest -t gustavobautista/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gustavobautista/multi-worker:latest -t gustavobautista/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gustavobautista/multi-client:latest
docker push gustavobautista/multi-server:latest
docker push gustavobautista/multi-worker:latest

docker push gustavobautista/multi-client:$SHA
docker push gustavobautista/multi-server:$SHA
docker push gustavobautista/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gustavobautista/multi-server:$SHA
kubectl set image deployments/client-deployment client=gustavobautista/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gustavobautista/multi-worker:$SHA