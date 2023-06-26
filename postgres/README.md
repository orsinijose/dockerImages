### Postgres

Simple local postgres 14 image to use for development:

```

docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres:14
```