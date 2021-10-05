build:
	docker build  -t jeduoliveira/lumisxp:14.1.0.210906  --build-arg LUMIS_VERSION=14.1.0.210906 .

scan: build
	docker scan --file Dockerfile jeduoliveira/14.1.0.210906

push:  build
	docker push jeduoliveira/lumisxp:14.1.0.210906
	