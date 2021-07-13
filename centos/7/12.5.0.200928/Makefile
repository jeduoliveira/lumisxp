build:
	docker build  -t jeduoliveira/lumisxp:12.5.0.200928-freeversion  --build-arg LUMIS_VERSION=12.5.0.200928-FreeVersion .

scan: build
	docker scan --file Dockerfile jeduoliveira/12.5.0.200928-freeversion

push:  build
	docker push jeduoliveira/lumisxp:12.5.0.200928-freeversion
	docker tag jeduoliveira/lumisxp:12.5.0.200928-freeversion jeduoliveira/lumisxp:latest
	docker push jeduoliveira/lumisxp:latest