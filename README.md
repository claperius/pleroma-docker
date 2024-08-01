# Pleroma
## Introduction
[Pleroma](https://pleroma.social/)  <em> "is a microblogging server software that can federate (= exchange messages with) other servers that support the same federation standards (OStatus and ActivityPub)."</em>

See [What is Pleroma](https://blog.soykaf.com/post/what-is-pleroma/) for more.


The purpose of this repository is to make it easy to build and deploy your own Pleroma instance using `docker` and `docker-compose`. 

## Installation
For the purpose of the document we assume that the destination directory is `~/pleroma`.

Clone repository:
```sh
git clone https://github.com/claperius/pleroma-docker.git
cd pleroma-docker
```

Create `.env` file using `.env-example`, replace all the values with the proper ones:
```sh
POSTGRES_PASSWORD=CHANGEME_PASS
PLEROMA_DOMAIN=example.com
PLEROMA_INSTANCE_NAME=Pleroma 
PLEROMA_ADMIN_EMAIL=admin@example.com
PLEROMA_NOTIFY_EMAIL=notify@example.com
PLEROMA_VER=v2.6.3
```

Copy all necessary files:
```sh
./create-deployment-dir.sh ~/pleroma
```

Go to destination directory:
```sh
cd ~/pleroma/deployment
```

Build docker image for pleroma:
```sh
./build-pleroma-docker.sh
```

Optional step - tweak the configuration in `~/pleroma/storage/config/config.exs`


Launch the instance - web and database:
```sh
docker-compose up -d
```

View logs:
```sh
docker logs -f pleroma_web
```

Make admin:
```sh
docker exec -it pleroma_web sh /pleroma/bin/pleroma_ctl user new YOUR_USERNAME admin@example.com --admin
```

## Web server configuration
For hosting pleroma behind Apache or Nginx - see:
* https://git.pleroma.social/pleroma/pleroma/-/blob/develop/installation/pleroma-apache.conf
* https://git.pleroma.social/pleroma/pleroma/-/blob/develop/installation/pleroma.nginx


## Migration
Migration to the new version.

Rebuild pleroma docker image:
```sh
cd ~/pleroma
./build-pleroma-docker.sh
```

Update postgresql image if needed:
```sh
docker-compose pull
```

Recreate containers:
```sh
docker-compose up -d # recreate the containers if needed
```

## Attribution
Based on: 
* https://github.com/angristan/docker-pleroma
* https://git.pleroma.social/pleroma/pleroma