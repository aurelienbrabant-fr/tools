CLIENT_GIT	:= git@github.com:aurelienbrabant-fr/client.git
SERVER_GIT	:= git@github.com:aurelienbrabant-fr/server.git

COMPOSE_DEV	= docker-compose -f docker-compose.dev.yml --env-file .dev.env

# md

all:
	@printf "Usage: make [dev-start | dev-stop]\n"

dev-start: dev-stop client-check-update server-check-update
	$(COMPOSE_DEV) pull
	$(COMPOSE_DEV) up --build -d

dev-stop:
	$(COMPOSE_DEV) down

dev-status:
	$(COMPOSE_DEV) ps

dev-logs:
	$(COMPOSE_DEV) logs

client-check-update: client
	@printf "Let's ensure client is up-to-date...\n"
	@cd client && git pull origin HEAD

client:
	git clone $(CLIENT_GIT) client

server-check-update: server
	@printf "Let's ensure server is up-to-date...\n"
	@cd server && git pull origin HEAD

server:
	git clone $(SERVER_GIT) server
