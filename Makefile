up:
	@docker-compose up -d

down:
	@docker-compose down

cli:
	@docker exec -it `docker ps -f name=memgraph -q` mgconsole
