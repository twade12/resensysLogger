# Containerized Resensys DbLogger

A containerized solution for Resensys DbLogger with built-in MySQL database for running standalone instances on cloud and other PCs.
* Infrastructure-independent
* OS Independent
* Installs Docker-CE on host
* Compatible with SenScope


### Getting Started
Clone the repo and run the following command substituting "4E34" with a particular site ID (format: XXXX):
```
sudo git clone https://github.com/xxxxxx/dockerLogger.git && cd dockerLogger/ && sudo bash linuxSetup.sh 4E34
```
Try without sudo if on macOS:
```
git clone https://github.com/xxxxxx/dockerLogger.git && cd dockerLogger/ && bash linuxSetup.sh 4E34
```
After a couple of seconds, you should have a running service consisting of two containerized applications: mysql-container and logger-container.

### Verify
To confirm that you have the system up and running with all dependencies, use the following steps:
1. Check that both containers are up and running and ports are properly configured. Status should be "Up" and logger exposed port 5555 should be redirected to internal port 5555. Similarly, MySQL exposed port 3307 should be mapped to internal port 3306.
```
sudo docker ps -a
```
```
CONTAINER ID   IMAGE                     COMMAND                  CREATED          STATUS          PORTS                               NAMES
832ddd77606d   resensys_logger:v2        "./DbLogger_5555"        10 minutes ago   Up 10 minutes   0.0.0.0:5555->5555/tcp              logger-container
8e80e243310a   mysql:5.7                 "docker-entrypoint.s…"   10 minutes ago   Up 10 minutes   33060/tcp, 0.0.0.0:3307->3306/tcp   mysql-container
```
2. Confirm that exposed ports are listening on host machine outside of containers:
```
sudo lsof -i -n -P | grep LISTEN
```
```
com.docke 34001        xxxxxxx 1754u  IPv6 0x4f75631bd60922a5      0t0    TCP *:3307 (LISTEN)
com.docke 34001        xxxxxxx 1756u  IPv6 0x4f75631bd6ed72a5      0t0    TCP *:5555 (LISTEN)
```
You should have two entries from docker listening on ports 5555 and 3307 to all hosts.

3. Now you should be able to connect to mysql from outside the container from any machine on the same network (sample shown for localhost):
```
mysql -h 127.0.0.1 -P 3307 -u root -p
```
Use default root password.

You can also login as the shm-admin user used for SenScope access.
```
mysql -h 127.0.0.1 -P 3307 -u shm-admin -pdqqtwngi
```
4. Connect an ethernet or Wi-Fi SeniMax with SID equal to the value entered in initial clone command (e.g. 4E34) and set server IP to host IP.
