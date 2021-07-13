build:
	docker build  -t jeduoliveira/lumisxp:14.0.0.210430  --build-arg LUMIS_VERSION=14.0.0.210430 .

scan: build
	docker scan --file Dockerfile jeduoliveira/14.0.0.210430

push:  build
	docker push jeduoliveira/lumisxp:14.0.0.210430
	docker tag jeduoliveira/lumisxp:14.0.0.210430 jeduoliveira/lumisxp:latest
	docker push jeduoliveira/lumisxp:latest