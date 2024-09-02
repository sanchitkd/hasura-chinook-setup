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



