Run AWX
=========

Runs an AWX deployment using `docker-compose`.

Requirements
------------

Has only been teseted for the following versions:

- OS:
  - Ubuntu 18.04
  - Ubuntu 16.04
- Database:
  - PostgresSQL 10
- AWX
  - 7.0.0
  - 8.0.0

We suggest encrypting the variables file using `ansible-vault`. For example:

```bash
ansible-vault create secrets.yml
```

And fill it like this:

```yaml
postgres_version: '10'
awx_version: '7.0.0'
```

Role Variables
--------------

| Variable | Type | Default | Comments | 
| -------- | ---- | ------- | -------- |
| `awx_admin_password` | String | `admin` | Password for the AWX administrator. |
| `awx_admin_username` | String | `admin` | Username for the AWX administrator. |
| `awx_database_host` | String | `postgres` | Hostname of the PostgreSQL database. |
| `awx_database_password` | String | `awx` | Password of the AWX database administrator. |
| `awx_database_port` | Number | `5432` | Port of the PostgreSQL database. |
| `awx_database_username` | String | `awx` | Username of the AWX database administrator. |
| `awx_database` | String | `awx` | Name of the AWX database. |
| `awx_memcached_host` | String | `alpine` | AWX Memcached container host. |
| `awx_memcached_image` | String | `memcached` | AWX Memcached container image. |
| `awx_memcached_port` | String | `alpine` | AWX Memcached container port. |
| `awx_memcached_version` | String | `alpine` | AWX Memcached container image version. |
| `awx_rabbitmq_default_vhost` | String | `awx` | AWX RabbitMQ default vhost. |
| `awx_rabbitmq_erlang_cookie` | String | `awx` | AWX RabbitMQ erlang cookie. |
| `awx_rabbitmq_host` | String | `rabbitmq` | AWX RabbitMQ host. |
| `awx_rabbitmq_image` | String | `ansible/awx_rabbitmq:3.7.4` | Version of the RabbitMQ container to use for AWX. |
| `awx_rabbitmq_password` | String | `rabbitmq` | AWX RabbitMQ password. |
| `awx_rabbitmq_port` | String | `rabbitmq` | AWX RabbitMQ port. |
| `awx_rabbitmq_user` | String | `rabbitmq` | AWX RabbitMQ user. |
| `awx_rabbitmq_version` | String | `3.7.4` | Version of the RabbitMQ container to use for AWX. |
| `awx_task_host` | String | `awxtask` | Hostname of the AWX task container. |
| `awx_task_image` | String | `ansible/awx_task:latest` | Image of the AWX web container. |
| `awx_version` | String | `latest` | AWX version. Check the [releases](https://github.com/ansible/awx/releases) page for all AWX versions. |
| `awx_web_host` | String | `awxweb` | Hostname of the AWX web container. |
| `awx_web_image` | String | `ansible/awx_web:latest` | Image of the AWX web container. |
| `external_network` | String | | External docker network. Useful to connect the DB to other containers connected to that docker network. |
| `project_dir` | String | `/tmp/lib` | Project directory where the `docker-compose.yml` file and other files will be stored. **Should be an absolute path**. |
| `remove_volumes` | Boolean | `False` | Flag that indicates if the volume related to the database container should be removed after destroying or updating the project. |
| `secret_key` | String |  | AWX secret key. |
| `state` | String | `present` | State of the project. If set to `present` the project will run the `docker-compose.yml` file. If set to `absent` it will stop all the containers and remove the `{{project_dir}}/postgres` folder from the server. |


Example Playbook
----------------

On this example we create a docker network before creating the containers. This is so that the containers from awx can talk to the database using an internal docker network.

To setup the database we use another role from CDH called `run_postgres`. When the database is created, we initialize the AWX database using a SQL script. The `run_postgres` role will take any SQL script provided inside the `sql_scripts` variable.

Templates variables are stored inside the `secrets.yaml` file, encrypted with `ansible-vault`.

Here is the `create_awx_database.sql` script:

```sql
CREATE USER {{ awx_database_username }} WITH ENCRYPTED PASSWORD '{{ awx_database_password }}';
CREATE DATABASE {{ awx_database }} OWNER {{ awx_database_username }};
```

```yaml
---
- hosts: server
  vars_files:
    - secrets.yaml
  vars:
    sql_scipts:
      - create_awx_database.sql
  tasks:
    - name: Create the docker network
      docker_network:
        name: '{{ external_network }}'
        state: 'present'
    - import_role: 
        name: conatel_digital_hub.run_postgres
    - import_role: 
        name: conatel_digital_hub.run_awx
```

License
-------

MIT
