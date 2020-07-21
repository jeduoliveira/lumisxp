
build:
	docker build  -t jeduoliveira/lumisxp:12.3.0.200408-centos-7-zulu-11  

build-free:
	docker build  -t jeduoliveira/lumisxp:12.3.0.200408-freeversion-centos-7-zulu-11  --build-arg LUMIS_VERSION=12.3.0.200408-FreeVersion  .

push-free: build-free
	docker push jeduoliveira/lumisxp:12.3.0.200408-freeversion-centos-7-zulu-11
	docker tag jeduoliveira/lumisxp:12.3.0.200408-freeversion-centos-7-zulu-11 jeduoliveira/lumisxp:latest
