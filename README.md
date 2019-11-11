## WeThink Enterprise Backup Client docker image

## Synopsis

Very small footprint docker image can be used to back up local storage on docker nodes like CoreOS etc.

## Installation and usage

Either pull the image directly from Docker Hub:
```
docker run -d --restart=always --name wethink-backup_client \
        -p 9102:9102 \
        -v /:/mnt:ro \
        -e FD_PASSWORD='WeThink Backup Client password' \
        -e FD_NAME=$(hostname) \
        wethinksolutionsbr/wethink-backup_client
```

Or build it locally:
```
git clone https://github.com/WeThinkSolutionsBR/WeThink-Backup_Client.git
docker build -t wethink-backup_client wethink-backup_client
```

Run the container:
```
docker run -d --restart=always --name wethink-backup_client \
	-p 9102:9102 \
	-v /:/mnt:ro \
	-e FD_PASSWORD='WeThink Backup Client password' \
	-e FD_NAME=$(hostname) \
	wethink-backup_client
```

## Credits

[Bacula (open source) containers for Docker by RedCoolBeans](https://github.com/RedCoolBeans/docker-bacula-opensource)

[Personalyzed by WeThink Solutions](https://www.wethinksolutions.com.br)
