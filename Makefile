
build:
	@(docker build  -t jeduoliveira/lumisxp:12.2.0.200122  .)
	
push: build
	docker push jeduoliveira/lumisxp:12.2.0.200122 
	docker tag jeduoliveira/lumisxp:12.2.0.200122 jeduoliveira/lumisxp:latest
	docker push jeduoliveira/lumisxp:latest