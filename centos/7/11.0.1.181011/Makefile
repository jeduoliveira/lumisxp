build:
	@(docker build  -t jeduoliveira/lumisxp:11.0.1.181011-centos-7-zulu-11  .)


build-free:
	@(docker build  -t jeduoliveira/lumisxp:11.0.1.181011-freeversion-centos-7-zulu-11  .)
	
push-free: build-free
	docker push jeduoliveira/lumisxp:11.0.1.181011-freeversion-centos-7-zulu-11
	
	
	


