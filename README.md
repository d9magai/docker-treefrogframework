# docker-treefrogframework

## Run Docker container

```
sudo docker run --name mysqld -e MYSQL_ROOT_PASSWORD=secret -d mysql
sudo docker run -i -p 8800:8800 --link  mysqld:mysql -t d9magai/treefrogframework bash
```

## Create a table

```
# mysql -h mysql -u root -p
Enter password: 

mysql> CREATE DATABASE blogdb DEFAULT CHARACTER SET utf8;
Query OK, 1 row affected (0.01 sec)

mysql> USE blogdb;
Database changed

mysql> CREATE TABLE blog (id INTEGER AUTO_INCREMENT PRIMARY KEY, title VARCHAR(20), body VARCHAR(200), created_at TIMESTAMP DEFAULT 0, updated_at TIMESTAMP DEFAULT 0, lock_revision INTEGER) DEFAULT CHARSET=utf8;
mysql> quit
```

## Generate the Application Skeleton

```
tspawn new blogapp
```

## Set the Database Information

```
[dev]
DriverType=QMYSQL
DatabaseName=blogdb
HostName=mysql
Port=
UserName=root
Password=secret
ConnectOptions=
```

## Automatic Generation of Code Created from the Table

```
tspawn scaffold blog
```

## Build the Source Code

```
qmake -r "CONFIG+=debug" "LIBS+=-L$TREEFROGFRAMEWORK_PREFIX/lib/" "INCLUDEPATH+=-I$TREEFROGFRAMEWORK_PREFIX/include/"
make
```

## To Start the Application Server

```
treefrog -d -e dev
```

Thanks for the link.
http://www.treefrogframework.org/documents/tutorial


