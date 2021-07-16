# ace-database-demo

This demo shows the use of ACE v11 with mysql; it is experimental, and here as a guide to one approach to getting the two products working together, but is not officially supported by IBM. Use as inspiration only (or as a cautionary tale, depending on the outcome!).

## Contents

This repo can be imported into the ACE v11 toolkit using the egit plugin (version 4.11; needed to install from a downloaded p2 repo) and built from there; alternatively, the PI file should contain the same contents. 

There are three applications designed to test various aspects of connectivity:
- JDBCTestApplication uses JDBC connectivity
- ODBCFromJavaTestApplication calls ESQL ODBC functionality from Java
- ODBCTestApplication tests ODBC from an ESQL Compute node, and can be run without a JVM.

The applications register HTTP endpoints of /jdbcTest, /odbcFromJavaTest, and /odbcTest respectively.

Need the drivers from https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.25.tar.gz

## Building
To customise this repo for use, simply update the DB2CloudSSL policy and db2dsdriver.cfg file to correct the hostname, rebuild the BAR, copy it into the docker/demo-container directory, and then build the two images.

The first image is based on https://github.com/ot4i/ace-docker/tree/master/experimental/ace-minimal and exists to provide a basic ACE v11 install. It contains a minimal set of ACE files to keep the container size small, and so some parts of the product (such as the webUI) do not work. For a runtime container, this is not a problem, and for full details of what can and cannot be removed, see the Dockefiles in the ot4i repo mentioned above. Build the minimal ODBC container needed here by running 
```
docker build -t ace-minimal-odbc:11.0.0.11-ubuntu -f Dockerfile.ubuntu .
```
in the docker/ace-minimal-odbc directory.

Once that is complete, update the db2dsdriver.cfg file in docker/demo-container to point to the correct host, and then build that container by running
```
docker build -t demo-container -f Dockerfile .        
```
to create the runtime container.

## Running 

Once that container has been built, run it as follows:
```
docker run --rm -ti -e DB_USER=<db2user> -e DB_PASSWORD=<db2password> -e MQSI_NO_CACHE_SUPPORT=1 -p 7800:7800 demo-container
```
to start the applications.

At this point, http://localhost:7800/odbcFromJavaTest (plus odbcTest and jdbcTest) should respond with a success message, if the credentials are correct on the docker run command.
