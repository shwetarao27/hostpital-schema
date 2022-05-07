# Sample Hospital Schema

Practicing creating realistic database schemas

## Run via Docker

Download [Docker Desktop](https://www.docker.com/products/docker-desktop/).

Once Docker is installed, run the following command from a command line environment (e.g. Git Bash). NOTE: Change `/path/to/repo` below to the actual location where the `hostpital-schema` repo directory is located on your machine.

    docker run -d \
        --name hospitaldb \
        -e MYSQL_ROOT_PASSWORD=password \
        -p 3306:3306 \
        -v /path/to/repo/hostpital-schema/schemas:/docker-entrypoint-initdb.d:Z \
        --platform linux/x86_64 \
        mysql:5.7.36 && docker logs -f hospitaldb

## Connect using MySQL Client

Once the MySQL Docker container is successfully running, run the following command from the command line environment.

    docker exec -it hospitaldb mysql -uhadmin -ppassword --protocol=tcp hospital

You should see a `mysql>` prompt after successful completion. Try running command to test successful startup.

    SHOW tables;

You should see an output similar to following if everything is working as expected.

    +---------------------+
    | Tables_in_hospital  |
    +---------------------+
    | active_admissions   |
    | admission_history   |
    | insurance_providers |
    | patients            |
    | rooms               |
    | staff               |
    | staff_roles         |
    +---------------------+

You're good to go!

## Stop database and clean up

To stop the database and clean up Docker run the following.

    docker stop hospitaldb;
    docker rm hospitaldb;
    docker system prune -f --volumes;

After this, you should be able to go back and do the "Run via Docker" step again.
