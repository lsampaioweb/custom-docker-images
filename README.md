# custom-docker-images
My own custom docker images.

```bash
docker build -t alpine-with-ca:latest -t alpine-with-ca:1.0 --build-arg CA_CERTIFICATE="$(cat ca.crt)" .

docker run -it --name alpine-with-ca-container alpine-with-ca
docker exec -it alpine-with-ca sh
```

```bash

```
