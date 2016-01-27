# docker-treefrogframework

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


