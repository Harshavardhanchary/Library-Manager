FROM mysql:8.0-oraclelinux8

ENV MYSQL_ROOT_PASSWORD=Root@1234
ENV MYSQL_DATABASE=Library_Manager

COPY data.sql /docker-entrypoint-initdb.d/data.sql

EXPOSE 3306

