CREATE USER {{ awx_database_username }} WITH ENCRYPTED PASSWORD '{{ awx_database_password }}';
CREATE DATABASE {{ awx_database }} OWNER {{ awx_database_username }};