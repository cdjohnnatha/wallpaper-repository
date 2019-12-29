DCMP = docker-compose
APP = marketplace_barebones
DCMP_EXEC_APP = ${DCMP} exec ${APP}
DCMP_RUN_APP = ${DCMP} run ${APP}

run:
	bundle install
	rm -f tmp/pids/server.pid
	bundle exec rails s -p 3000 -b '0.0.0.0'

up:
	${DCMP} up

down:
	${DCMP} down

bash:
	${DCMP_EXEC_APP} bash

console:
	${DCMP_EXEC_APP} rails c

restart-app:
	${DCMP} restart ${APP}

build:
	${DCMP} build --no-cache

rebuild:
	make down
	${DCMP} build --no-cache

docker-createdb:
	${DCMP_RUN_APP} make createdb

createdb:
	bundle exec rails db:drop
	bundle exec rails db:create
	bundle exec rails db:migrate
	bundle exec rails db:seed
	bundle exec rails db:test:prepare

postgresdb:
	docker run -d --hostname postgresdb -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -v pg_data:/var/lib/postgresql/data postgres:9.6
