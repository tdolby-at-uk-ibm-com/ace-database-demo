# Docker image build file for the demo application

This image is based on the ACE minimal Ubuntu container, but several things have needed to be added.

- deploy-bars.sh is used during the image build process to deploy the application BAR file
- init-creds.sh reads the database credentials from environment variables DB_USER/DB_PASSWORD and updates both the setdbparms information for the server and also the JDBC policy. Note that these would normally be secrets or vault-provided for production use.
- db2dsdriver.cfg contains the DB2 on Cloud location
- odbc.ini contains a reference to the DB2 Data Server Driver provided with ACE v11
- db2-11.5.4.0-full-icc.tar.gz is a copy of the /opt/ibm/db2/V11.5/lib64/icc directory from an 11.5.4 client install. This directory is used to replace the one in /opt/ibm/ace-11/server/ODBC/dsdriver/odbc_cli/clidriver/lib and it is highly unlikely that this is a supported configuration . . . 

The BAR file from the projects must be copied into this directory if it is changed in the BARFiles directory above; docker won't allow a reference to a parent directory in a COPY statement so the file must be copied in first.

db2dsdriver.cfg and the similar DB2CloudSSL policy need to be updated to use a valid DB2 on Cloud hostname.

Run as follows:
```
docker run --rm -ti -e DB_USER=<db2clouduser> -e DB_PASSWORD=<db2cloudpassword> -e MQSI_NO_CACHE_SUPPORT=1 -p 7800:7800 demo-container
```
