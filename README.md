Hasura GraphQL with Chinook Database


## Pre-requisites:
- Please insall git if not already installed.
```
C:\Users\#\Desktop>winget install --id Git.Git -e --source winget
Found Git [Git.Git] Version 2.46.0
This application is licensed to you by its owner.
Microsoft is not responsible for, nor does it grant any licenses to, third-party packages.
Downloading https://github.com/git-for-windows/git/releases/download/v2.46.0.windows.1/Git-2.46.0-64-bit.exe
  ██████████████████████████████  65.0 MB / 65.0 MB
Successfully verified installer hash
Starting package install...
The installer will request to run as administrator, expect a prompt.
Successfully installed

C:\Users\#\Desktop>
```
- If unable to Run git.
```
C:\Windows\System32>git
'git' is not recognized as an internal or external command,
operable program or batch file.
```
- Please run the below command to add the Path to the environment variable. Restart the Command Prompt and make sure this path is showing in %PATH%
```
C:\Windows\System32>setx PATH "%PATH%;C:\Program Files\Git\cmd"
C:\Windows\System32>echo %PATH%
```
- Please install Docker if not already installed and run `docker ps` to make sure there are containers running.

## Setup Steps
1. Clone the Repository
`git clone https://github.com/sanchitkd/hasura-chinook-setup-task_1.git`

2. Navigate to Directory
`cd hasura-chinook-setup-task_1`

3. Start Services
`docker-compose up -d`
```
C:\Users\#\Desktop\hasura-chinook-setup-task_1>docker-compose up -d
[+] Running 24/24
 ✔ hasura Pulled                                                                                                                                                                                                                       81.7s
   ✔ 43f89b94cd7d Pull complete                                                                                                                                                                                                        31.3s
   ✔ a22745954bfd Pull complete                                                                                                                                                                                                        31.3s
   ✔ 4c4b6cdcd409 Pull complete                                                                                                                                                                                                        56.6s
   ✔ 2ef6b049045d Pull complete                                                                                                                                                                                                        56.8s
   ✔ a1d0d2497664 Pull complete                                                                                                                                                                                                        60.5s
   ✔ 554e2a06d246 Pull complete                                                                                                                                                                                                        61.2s
   ✔ 485f32ae48c3 Pull complete                                                                                                                                                                                                        73.4s
   ✔ 34aaf3415e29 Pull complete                                                                                                                                                                                                        73.6s
 ✔ postgres Pulled                                                                                                                                                                                                                     72.2s
   ✔ e4fff0779e6d Pull complete                                                                                                                                                                                                        13.0s
   ✔ 6cf30cfc822c Pull complete                                                                                                                                                                                                        13.1s
   ✔ af1d574c3ad1 Pull complete                                                                                                                                                                                                        13.3s
   ✔ 9770b3362dda Pull complete                                                                                                                                                                                                        14.0s
   ✔ dda3697c5b16 Pull complete                                                                                                                                                                                                        15.9s
   ✔ f198a7595590 Pull complete                                                                                                                                                                                                        16.0s
   ✔ eb4191d05878 Pull complete                                                                                                                                                                                                        16.0s
   ✔ 1d0eb8a8dbad Pull complete                                                                                                                                                                                                        16.1s
   ✔ 66f0b6ddcec2 Pull complete                                                                                                                                                                                                        64.1s
   ✔ 66c9ebb47429 Pull complete                                                                                                                                                                                                        64.2s
   ✔ eea6f96f604b Pull complete                                                                                                                                                                                                        64.2s
   ✔ b7c08779da16 Pull complete                                                                                                                                                                                                        64.2s
   ✔ 32dc030c5211 Pull complete                                                                                                                                                                                                        64.2s
   ✔ 32ceea7ae699 Pull complete                                                                                                                                                                                                        64.2s
[+] Running 3/3
 ✔ Network hasura-chinook-setup-task_1_default       Created                                                                                                                                                                            0.1s
 ✔ Container hasura-chinook-setup-task_1-postgres-1  Started                                                                                                                                                                            1.6s
 ✔ Container hasura-chinook-setup-task_1-hasura-1    Started                                                                                                                                                                            0.7s

C:\Users\#\Desktop\hasura-chinook-setup-task_1>
```
5. Run `docker ps` command to list the Running container and look for `CONTAINER ID` of the postgres. Here it is `hasura-chinook-setup-task_1-postgres-1`
```
C:\Users\#\Desktop\hasura-chinook-setup-task_1>docker ps
CONTAINER ID   IMAGE                           COMMAND                   CREATED              STATUS                        PORTS                                       NAMES
fac00099b336   hasura/graphql-engine:v2.35.0   "/bin/sh -c '\"${HGE_…"   About a minute ago   Up About a minute (healthy)   0.0.0.0:8081->8080/tcp, :::8081->8080/tcp   hasura-chinook-setup-task_1-hasura-1
59190d49fca6   postgres:13                     "docker-entrypoint.s…"    About a minute ago   Up About a minute             0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   hasura-chinook-setup-task_1-postgres-1
```
6. Run `docker cp Chinook_PostgreSql.sql <CONTAINER ID>:/Chinook_PostgreSql.sql` to mount the DB on the postgres container
```
C:\Users\#\Desktop\hasura-chinook-setup-task_1>docker cp Chinook_PostgreSql.sql  hasura-chinook-setup-task_1-postgres-1:/Chinook_PostgreSql.sql
Successfully copied 602kB to hasura-chinook-setup-task_1-postgres-1:/Chinook_PostgreSql.sql

C:\Users\#\Desktop\hasura-chinook-setup-task_1>
```
7. Run `docker exec -it <Container ID> bash` to enter the Container. `C:\Users\#\Desktop\hasura-chinook-setup-task_1>docker exec -it hasura-chinook-setup-task_1-postgres-1 bash`
8. Run `psql -U chinook_user -d chinook -f Chinook_PostgreSql.sql` to execute the the sql script. Then run `psql -U chinook_user -d chinook;` to login to the DB. Make sure the tables are listed by running `\dt`.
```
root@59190d49fca6:/# psql -U chinook_user -d chinook -f Chinook_PostgreSql.sql
root@59190d49fca6:/# psql -U chinook_user -d chinook;
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
```  

9. Access Hasura Console
- Open http://localhost:8081 in your browser.
- Admin secret: `myadminsecretkey`
