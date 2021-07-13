build:
	docker build  -t jeduoliveira/lumisxp:12.4.0.200625-centos-7-zulu-11  .

build-free:	
	docker build  -t jeduoliveira/lumisxp:12.4.0.200625-freeversion-centos-7-zulu-11  .
	#docker-slim build --show-blogs --dockerfile Dockerfile --tag jeduoliveira/lumisxp:12.4.0.200625-freeversion-centos-7-zulu-11 .

push-free: build-free	
	docker push jeduoliveira/lumisxp:12.4.0.200625-freeversion-centos-7-zulu-11
	docker tag jeduoliveira/lumisxp:12.4.0.200625-freeversion-centos-7-zulu-11 jeduoliveira/lumisxp:latest
	docker push jeduoliveira/lumisxp:latest
