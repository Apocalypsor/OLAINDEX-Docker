# OLAINDEX Docker

## OLAINDEX

https://github.com/WangNingkai/OLAINDEX

## Set Up

1. Edit env file, save as `env.conf`

https://github.com/WangNingkai/OLAINDEX/blob/master/.env.example

2. create the  `storage` directory

```bash
mkdir storage && chmod -R 777 storage
```

3. Start server

```bash
curl https://raw.githubusercontent.com/Apocalypsor/OLAINDEX-Docker/master/docker-compose.yaml > docker-compose.yaml
docker-compose up -d

```

4. Set up reverse proxy