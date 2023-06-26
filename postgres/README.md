### Postgres

Simple local postgres 14 image to use for development:

```
docker run --name psql14 -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres:14
```