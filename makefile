# Todo: 修改 [db-name]
DB_NAME=[db-name]
table=
# TODO: 修改 远程 docker 镜像地址
REMOTE_DOCKER=[remote-docker-url]
service=
SERVICE_NAME=targetproject
VERSION= v$(shell date +%Y%m%d).$(shell date +%H)
.PHONY: rpc api model model-c

# Todo: 修改 [roc-name]
rpc:
	goctl rpc protoc rpc/[rpc-name].proto --go_out=rpc --go-grpc_out=rpc --zrpc_out=rpc -home template  -m
# Todo: 修改 [api-name]
api:
	goctl api go -api api/[api-name].api  --dir=./api --home template
docker:
	echo "goctl docker --go $(service)/$(SERVICE_NAME).go  --home template"
model:
	goctl model mysql datasource -url="root:123456@tcp(127.0.0.1:3306)/$(DB_NAME)" -table="$(table)"   -dir="./rpc/models" --home template  --cache=false
# make model table=xxxxx
model-c:
	goctl model mysql datasource -url="root:123456@tcp(127.0.0.1:3306)/$(DB_NAME)" -table="$(table)"   -dir="./rpc/models" -c --home template

.PHONY: build tag push auto
build:
	docker build -t targetproject-$(service):${VERSION} -f $(service)/Dockerfile .
tag:
	docker tag $(SERVICE_NAME)-$(service):${VERSION} $(SERVICE_NAME)-$(service):latest
tag-pro:
	docker tag $(SERVICE_NAME)-$(service):${VERSION} $(REMOTE_DOCKER)/$(SERVICE_NAME)-$(service):${VERSION}
	docker tag $(SERVICE_NAME)-$(service):${VERSION} $(REMOTE_DOCKER)/$(SERVICE_NAME)-$(service):latest
push:
	docker push $(REMOTE_DOCKER)/$(SERVICE_NAME)-$(service):${VERSION}
	docker push $(REMOTE_DOCKER)/$(SERVICE_NAME)-$(service):latest

auto: build tag-pro push
