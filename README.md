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
If unable to Run git.
```
C:\Windows\System32>git
'git' is not recognized as an internal or external command,
operable program or batch file.
```
Please run the below command to add the Path to the environment variable. Restart the Command Prompt and make sure this path is showing in %PATH%
```
C:\Windows\System32>setx PATH "%PATH%;C:\Program Files\Git\cmd"
C:\Windows\System32>echo %PATH%
```

## Setup Steps
1. Clone the Repository
`git clone https://github.com/sanchitkd/hasura-chinook-setup-task_1.git`

2. Navigate to Directory
`cd hasura-chinook-setup-task_1`

3. Start Services
`docker-compose up -d`

4. Access Hasura Console
- Open http://localhost:8081 in your browser.
- Admin secret: `myadminsecretkey`
