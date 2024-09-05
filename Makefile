build:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

debug: up
	docker attach --detach-keys="ctrl-c" remi_api

bundle:
	docker compose exec app bash -c "bin/bundle install"

bash:
	docker compose exec app bash

console:
	docker compose exec app bash -c "bin/rails c"

prepare:
	docker compose exec app bash -c "bin/rails db:prepare"

migrate:
	docker compose exec app bash -c "bin/rails db:migrate"

routes:
	docker compose exec app bash -c "bin/rails routes"

routes_grep:
	docker compose exec app bash -c "bin/rails routes | grep $(name)"

attach-log:
	docker compose exec app bash -c "tail -f log/development.log"

seed:
	docker compose exec app bash -c "bin/rails db:seed"

npm-install:
	docker compose exec -it app_frontend npm install $(package) --save

logs:
	docker compose logs $(name)

restart:
	docker compose down && docker compose up -d
