build:
	docker build  -t public.ecr.aws/p7k8w7p7/lumisxp:16.0.0.230707-FreeVersion  --build-arg LUMIS_VERSION=16.0.0.230707-FreeVersion .

scan: build
	docker scan --file Dockerfile public.ecr.aws/p7k8w7p7/lumisxp:16.0.0.230707-FreeVersion

push:  build
	docker push public.ecr.aws/p7k8w7p7/lumisxp:16.0.0.230707-FreeVersion
	