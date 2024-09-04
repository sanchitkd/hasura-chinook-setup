Challenges and Troubleshooting
______________________________

## Challenge 1: 
- Issue: Docker compose file not found.
C:\Users\Default\Desktop>docker-compose up -d
no configuration file provided: not found
- Solution: Change the directory to the location where the docker-compose.yml is present.
C:\Users\Dell\OneDrive\Desktop\HASURA>cd C:\Users\Dell\OneDrive\Desktop\HASURA\

C:\Users\Dell\OneDrive\Desktop\HASURA>dir
 Volume in drive C has no label.
 Volume Serial Number is 887A-6CA7

 Directory of C:\Users\Dell\OneDrive\Desktop\HASURA

02-09-2024  17:02    <DIR>          .
02-09-2024  17:02    <DIR>          ..
02-09-2024  00:20           600,200 Chinook_PostgreSql.sql
02-09-2024  15:41               673 docker-compose.yml
02-09-2024  17:03    <DIR>          hasura-chinook-setup
02-09-2024  00:17    <DIR>          tech-eval
               3 File(s)        603,015 bytes
               5 Dir(s)  122,580,738,048 bytes free

C:\Users\Dell\OneDrive\Desktop\HASURA>


## Challenge 2: 
- Issue: Getting the warning, "the attribute `version` is obsolete".
C:\Users\Dell\OneDrive\Desktop\HASURA>docker-compose up -d
time="2024-09-02T13:02:15+05:30" level=warning msg="C:\\Users\\Dell\\OneDrive\\Desktop\\HASURA\\docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion"
[+] Running 3/3
 ✔ Network hasura_default         Created                                                                                                                              0.1s
 ✔ Volume "hasura_postgres-data"  Created                                                                                                                              0.0s
 ✔ Container hasura-postgres-1    Started  

- Solution: Update the docker-compose.yml file and remove the version attribute.
# C:\Users\Dell\OneDrive\Desktop\HASURA\docker-compose.yml
version: '3.8'
services:


## Challenge 3: 
- Issue: Got the error, "Bind for 0.0.0.0:8080 failed: port is already allocated"
C:\Users\Dell\OneDrive\Desktop\HASURA>docker-compose up -d
[+] Running 1/2
 ✔ Container hasura-postgres-1  Running                                                                                                                                0.0s
 - Container hasura-hasura-1    Starting                                                                                                                               0.2s
Error response from daemon: driver failed programming external connectivity on endpoint hasura-hasura-1 (ecaab181986daa46b5578914c5340660617d07f3a850c15e12d1b545e860d2e9): Bind for 0.0.0.0:8080 failed: port is already allocated

- Solution: The port 8080 is already in use. Find and kill the process using this port.
C:\Users\Dell\OneDrive\Desktop\HASURA>netstat -aon | findstr :8080
  TCP    0.0.0.0:8080           0.0.0.0:0              LISTENING       15400
  TCP    [::]:8080              [::]:0                 LISTENING       15400
  TCP    [::1]:8080             [::]:0                 LISTENING       16356
  TCP    [::1]:8080             [::1]:53923            TIME_WAIT       0
  TCP    [::1]:8080             [::1]:53924            TIME_WAIT       0
  TCP    [::1]:8080             [::1]:53925            TIME_WAIT       0
  TCP    [::1]:8080             [::1]:53934            TIME_WAIT       0

C:\Users\Dell\OneDrive\Desktop\HASURA>netstat -aon | findstr :8080
  TCP    [::1]:8080             [::]:0                 LISTENING       16356

Open the Task Manager > Go to the Details tab > Find the process with the matching PID and terminate it.

Port 8080 is used by the Docker Desktop application. Update the C:\Users\Dell\OneDrive\Desktop\HASURA\docker-compose.yml file
    ports:
      - "8080:8080"


## Challenge 4:
- Issue: After running the docker-compose and loading the database we were unable to list any tables in the database.

root@e29260c98ad7:/# psql -U chinook_user -d chinook_db;
psql (13.16 (Debian 13.16-1.pgdg120+1))
Type "help" for help.

chinook_db=#
chinook_db=# \dt
Did not find any relations.
chinook_db=# \dn
      List of schemas
    Name     |    Owner
-------------+--------------
 hdb_catalog | chinook_user
 public      | chinook_user
(2 rows)

chinook_db=# \dt public.*
Did not find any relation named "public.*".
chinook_db=# \d
Did not find any relations.
chinook_db=# \q
root@e29260c98ad7:/# exit
exit

We ran the docker logs graphql-postgres-1 command to check the docker logs. 

What's next:
    Try Docker Debug for seamless, persistent debugging tools in any container or image → docker debug graphql-postgres-1
    Learn more at https://docs.docker.com/go/debug-cli/

C:\Users\sd000072\Desktop\GraphQL>docker logs graphql-postgres-1
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... Etc/UTC
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... ok
syncing data to disk ... ok


Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
waiting for server to start....2024-09-04 04:44:10.187 UTC [49] LOG:  starting PostgreSQL 13.16 (Debian 13.16-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
2024-09-04 04:44:10.192 UTC [49] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2024-09-04 04:44:10.206 UTC [50] LOG:  database system was shut down at 2024-09-04 04:44:09 UTC
2024-09-04 04:44:10.213 UTC [49] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

2024-09-04 04:44:10.451 UTC [49] LOG:  received fast shutdown request
waiting for server to shut down....2024-09-04 04:44:10.455 UTC [49] LOG:  aborting any active transactions
2024-09-04 04:44:10.457 UTC [49] LOG:  background worker "logical replication launcher" (PID 56) exited with exit code 1
2024-09-04 04:44:10.457 UTC [51] LOG:  shutting down
2024-09-04 04:44:10.486 UTC [49] LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

2024-09-04 04:44:10.579 UTC [1] LOG:  starting PostgreSQL 13.16 (Debian 13.16-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
2024-09-04 04:44:10.682 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2024-09-04 04:44:10.682 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2024-09-04 04:44:10.698 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2024-09-04 04:44:10.748 UTC [64] LOG:  database system was shut down at 2024-09-04 04:44:10 UTC
2024-09-04 04:44:10.753 UTC [1] LOG:  database system is ready to accept connections
2024-09-04 04:44:11.554 UTC [71] ERROR:  relation "hdb_catalog.hdb_version" does not exist at character 69
2024-09-04 04:44:11.554 UTC [71] STATEMENT:
                SELECT ee_client_id::text, ee_client_secret
                  FROM hdb_catalog.hdb_version


C:\Users\sd000072\Desktop\GraphQL>

- Solution:
We checked the Chinook_PostgreSql.sql script and found the table name is chinook.
DROP DATABASE IF EXISTS chinook;


/*******************************************************************************
   Create database
********************************************************************************/
CREATE DATABASE chinook;


\c chinook;

However in the docker-compose.yaml file, the DB name was chinook_db
services:
  postgres:
    image: postgres:13
    restart: always
    environment:
      POSTGRES_USER: chinook_user
      POSTGRES_PASSWORD: chinook_pass
      POSTGRES_DB: chinook_db

I corrected the docker-compose.yaml file with the correct DB name and re-run the workflow.

C:\Users\sd000072\Desktop\GraphQL>docker-compose up -d
[+] Running 4/4
 ✔ Network graphql_default         Created                                                                                                                                                                                             0.1s
 ✔ Volume "graphql_postgres-data"  Created                                                                                                                                                                                             0.0s
 ✔ Container graphql-postgres-1    Started                                                                                                                                                                                             0.6s
 ✔ Container graphql-hasura-1      Started                                                                                                                                                                                             1.0s

C:\Users\sd000072\Desktop\GraphQL>docker ps
C:\Users\sd000072\Desktop\GraphQL>docker cp Chinook_PostgreSql.sql graphql-postgres-1:/Chinook_PostgreSql.sql
Successfully copied 602kB to graphql-postgres-1:/Chinook_PostgreSql.sql
C:\Users\sd000072\Desktop\GraphQL>docker exec -it graphql-postgres-1 bash
root@4b8a900f2dc7:/# psql -U chinook_user -d chinook -f Chinook_PostgreSql.sql
root@4b8a900f2dc7:/# psql -U chinook_user -d chinook;
psql (13.16 (Debian 13.16-1.pgdg120+1))
Type "help" for help.

chinook=# \dt
               List of relations
 Schema |      Name      | Type  |    Owner
--------+----------------+-------+--------------
 public | album          | table | chinook_user
 public | artist         | table | chinook_user
 public | customer       | table | chinook_user
 public | employee       | table | chinook_user
 public | genre          | table | chinook_user
 public | invoice        | table | chinook_user
 public | invoice_line   | table | chinook_user
 public | media_type     | table | chinook_user
 public | playlist       | table | chinook_user
 public | playlist_track | table | chinook_user
 public | track          | table | chinook_user
(11 rows)

chinook=#
