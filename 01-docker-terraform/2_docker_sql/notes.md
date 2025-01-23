###Used Commands

##DE Zoomcamp 1.2.2

docker run -it 
-e POSTGRES_USER="root" 
-e POSTGRES_PASSWORD="root" 
-e POSTGRES_DB="ny_taxi" 
-v /workspaces/DEZoomcamp2025/01-docker-terraform/2_docker_sql/ny_taxi_postgres_data:/var/lib/postgresql/data 
-p 5432:5432 
postgres:13


pgcli -h localhost -p 5432 -u root -d ny_taxi




##DE Zoomcamp 1.2.3

docker run -it 
-e PGADMIN_DEFAULT_EMAIL="admin@admin.com" 
-e PGADMIN_DEFAULT_PASSWORD="root" 
-p 8080:80 
dpage/pgadmin4

#Network
docker network create pg-network

docker network inspect pg-network


docker run -it 
-e POSTGRES_USER="root" 
-e POSTGRES_PASSWORD="root" 
-e POSTGRES_DB="ny_taxi" 
-v /workspaces/DEZoomcamp2025/01-docker-terraform/2_docker_sql/ny_taxi_postgres_data:/var/lib/postgresql/data 
-p 5432:5432 
--network=pg-network 
--name pg-database 
postgres:13


docker start pg-database

docker stop pg-database

docker run -it 
-e PGADMIN_DEFAULT_EMAIL="admin@admin.com" 
-e PGADMIN_DEFAULT_PASSWORD="root" 
-p 8080:80 
--network=pg-network 
--name pgadmin 
dpage/pgadmin4

docker start pgadmin

docker stop pgadmin


##DE Zoomcamp 1.2.4

python ingest_data.py 
--user=root 
--password=root 
--host=localhost 
--port=5432 
--db=ny_taxi 
--table_name=yellow_taxi_data 
--url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz


docker build -t taxi_ingest:v001 .

docker run -it 
--network=pg-network 
taxi_ingest:v001 
--user=root 
--password=root 
--host=pg-database 
--port=5432 
--db=ny_taxi 
--table_name=yellow_taxi_data 
--url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz



##DE Zoomcamp 1.2.5

docker-compose up

OR

docker-compose up -d




docker-compose down
