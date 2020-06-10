PWD=$(shell pwd)
DATABASE_PASSWD=root
DATABASE_USER=root
MYSQL57_SERVICE=mysql57
POSTGRES12_SERVICE=postgres12

mysql57-up:
	@echo "starting mysql 5.7"
	@docker run \
		--rm \
		-v ${PWD}/mysql57-data:/var/lib/mysql \
		-p 3306:3306 \
		--name ${MYSQL57_SERVICE} \
		-e MYSQL_ROOT_PASSWORD=${DATABASE_PASSWD} \
		-d \
		mysql:5.7

mysql57-down:	
	@echo "stoping mysql 5.7"
	@docker stop ${MYSQL57_SERVICE}
	@echo "mysql 5.7 stoped"

mysql57-shell:
	@echo "Welcome to mysql57 command line"
	@docker exec -it ${MYSQL57_SERVICE} mysql -u${DATABASE_USER} -p${DATABASE_PASSWD}

mysql57-ip:
	@echo "IP from container ${POSTGRES12_SERVICE}"	
	@docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${MYSQL57_SERVICE}

postgres12-up:
	@echo "starting postgres 12"
	@docker run \
		--rm \
		-v ${PWD}/postgres12-data:/var/lib/postgresql/data \
		-p 5433:5432 \
		--name ${POSTGRES12_SERVICE} \
		--hostname ${POSTGRES12_SERVICE} \
		-e POSTGRES_USER=${DATABASE_USER} \
		-e POSTGRES_PASSWORD=${DATABASE_PASSWD} \
		-d \
		postgres:12

postgres12-down:	
	@echo "stoping postgres 12"
	@docker stop ${POSTGRES12_SERVICE}
	@echo "postgres 12 stoped"

postgres12-shell:
	@echo "Welcome to postgres 12 command line"
	@docker exec -it ${POSTGRES12_SERVICE} psql postgresql://${DATABASE_USER}:${DATABASE_PASSWD}@localhost:5432

postgres12-ip:
	@echo "IP from container ${POSTGRES12_SERVICE}"	
	@docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${POSTGRES12_SERVICE}
