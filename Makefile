all: srcs/.env build

build:
	mkdir -p /home/febonaer/data/mariadb
	mkdir -p /home/febonaer/data/wordpress
	@docker-compose --file=srcs/docker-compose.yml up -d

fclean:
	@docker stop $(shell docker ps -qa)
	@docker rm $(shell docker ps -qa)
	@docker image rm -f $(shell docker images -qa)
	@docker volume rm $(shell docker volume ls -q)
	@docker network rm srcs_inception
	sudo rm -rf /home/febonaer/data/mariadb
	sudo rm -rf /home/febonaer/data/wordpress

prune:
	@docker system prune -a --volumes

srcs/.env:
	@echo "Missing .env file" && exit 1

re: fclean build

.PHONY: all build fclean re prune
