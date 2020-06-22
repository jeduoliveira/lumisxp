build:
	@(docker build  -t jeduoliveira/lumisxp:11.2.0.190404-centos-7-openjdk-8  .)


build-free:
	@(docker build  -t jeduoliveira/lumisxp:11.2.0.190404-freeversion-centos-7-openjdk-8  .)
	
push-free: build-free
	docker push jeduoliveira/lumisxp:11.2.0.190404-freeversion-centos-7-openjdk-8
	
	
	


