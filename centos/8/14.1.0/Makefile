build:
	docker build  -t jeduoliveira/lumisxp:14.1.0.210906-freeversion-centos-8-zulu-11  --build-arg LUMIS_VERSION=14.1.0.210906-FreeVersion .

scan: build
	docker scan --file Dockerfile jeduoliveira/14.1.0.210906-freeversion-centos-8-zulu-11

push:  build
	docker push jeduoliveira/lumisxp:14.1.0.210906-freeversion-centos-8-zulu-11
	