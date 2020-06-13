build:
	@(docker build  -t jeduoliveira/lumisxp:12.1.0.191010-centos-7-zulu-11  .)


build-free:
	@(docker build  -t jeduoliveira/lumisxp:12.1.0.191010-freeversion-centos-7-zulu-11 .)
	
push-free: build-free
	docker push jeduoliveira/lumisxp:12.1.0.191010-freeversion-centos-7-zulu-11
	docker tag jeduoliveira/lumisxp:12.1.0.191010-freeversion-centos-7-zulu-11 jeduoliveira/lumisxp:latest
	docker push jeduoliveira/lumisxp:latest
	


