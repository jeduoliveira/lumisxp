build:
	@(docker build  -t jeduoliveira/lumisxp:12.2.0.200122-centos-7-zulu-11  .)


build-free:
	@(docker build  -t jeduoliveira/lumisxp:12.3.0.200408-FreeVersion-centos-7-zulu-11  .)
	
push-free: build-free
	docker push jeduoliveira/lumisxp:12.3.0.200408-FreeVersion-centos-7-zulu-11
	docker tag jeduoliveira/lumisxp:12.3.0.200408-FreeVersion-centos-7-zulu-11 jeduoliveira/lumisxp:latest
	docker push jeduoliveira/lumisxp:latest
	


