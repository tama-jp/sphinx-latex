#!/usr/bin/env bash

if [ "$1" = "refresh" ]; then
	rm -rf ./data

	docker compose down
else
	docker compose stop
fi

# docker-compose up --buil -d
# docker-compose logs -f --tail=500

docker compose up --build
