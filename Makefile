PWD=$(shell pwd)
DATABASE_PASSWD=root
DATABASE_USER=root

mysql57-up:
	@echo "starting mysql 5.7"
	@docker run \
		--rm \
		-v ${PWD}/mysql57-data:/var/lib/mysql \
		-p 3306:3306 \
		--name mysql57 \
		-e MYSQL_ROOT_PASSWORD=${DATABASE_PASSWD} \
		-d \
		mysql:5.7

mysql57-down:	
	@echo "stoping mysql 5.7"
	@docker stop mysql57
	@echo "mysql 5.7 stoped"

mysql57-shell:
	@echo "Welcome to mysql57 command line"
	@docker exec -it mysql57 mysql -u${DATABASE_USER} -p${DATABASE_PASSWD}

