#
# NB:  This is not the "modern" method of managing Docker networks
#      and containers.  We'll use docker-compose for that later.
#

all:
	@echo "Usage:  make launch"

network:
	docker network inspect dictionary-net > /dev/null 2>&1 ;\
	if [ $$? -ne 0 ]; then                                  \
	docker network create --driver bridge dictionary-net;   \
    fi

launch:  clean network api nginx redis
	docker run -d --name redis --network dictionary-net dictionary-redis
	docker run -d --name c1 --env-file api/c1.env --network dictionary-net dictionary-api
	docker run -d --name c2 --env-file api/c2.env --network dictionary-net dictionary-api
	docker run -d --name nginx --network dictionary-net -p80:80 dictionary-nginx

api:
	docker build --tag dictionary-api api

nginx:
	docker build --tag dictionary-nginx nginx

redis:
	docker build --tag dictionary-redis redis

CONTAINERS=redis c1 c2 nginx
stop:
	for c in "$(CONTAINERS)"; do                \
	docker container stop $$c > /dev/null 2>&1; \
	done || true
	docker container prune --force

clean:  stop
	docker container rm redis c1 c2 nginx > /dev/null 2>&1 || true

