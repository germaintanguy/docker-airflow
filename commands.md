```
docker build -t docker-airflow .
docker tag airflow germaintanguy/docker-airflow:1.8.2rc1
docker push germaintanguy/docker-airflow:1.8.2rc1
docker stack deploy -c docker-compose-CeleryExecutor.yml airflow

docker stack ls
docker service ls
docker service logs airflow_webserver -f
docker ps
docker exec -ti 56a9c494db78 bash

docker service scale airflow_worker=3

docker stack rm airflow

```
