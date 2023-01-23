build:
	docker-compose build

setup:
	docker-compose run --rm sinatra /bin/bash scripts/init.sh

up:
	docker-compose up -d postgres
	docker-compose up sinatra

down:
	docker-compose down

install_dependencies:
	docker-compose run --rm sinatra bundle install

console:
	docker-compose run --rm sinatra bin/console