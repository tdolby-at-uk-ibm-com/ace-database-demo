# Copyright (c) 2020 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)

FROM ace-minimal-odbc:12.0.1.0-ubuntu

# docker build -t demo-container -f Dockerfile .

#
# This image is used to run integration solutions in a cloud.
# 
# Starting from ace-minimal (which has the ACE install plus the aceuser created), this
# image contains the deployed BAR files for a given application as well as a script to
# read secrets and populate appropriate ACE configuration.
#

LABEL "maintainer"="tdolby@uk.ibm.com"
USER root
WORKDIR /
COPY deploy-bars.sh /tmp/
COPY init-creds.sh /tmp/
COPY AllApplicationsAndPolicies.bar /tmp/
COPY db2dsdriver.cfg /home/aceuser/db2dsdriver.cfg
COPY odbc.ini /home/aceuser/odbc.ini
RUN chown aceuser /tmp/* && chmod 775 /tmp/*sh && chown aceuser /home/aceuser/* 

#COPY db2-11.5.4.0-full-icc.tar.gz /tmp/db2-11.5.4.0-full-icc.tar.gz
#RUN cd /tmp && \
#    tar -xf db2-11.5.4.0-full-icc.tar.gz && \
#    cd /opt/ibm/ace-12/server/ODBC/dsdriver/odbc_cli/clidriver/lib && \
#    mv icc icc-orig && \
#    ln -s /tmp/icc icc

#COPY gskssl64.tar.gz /tmp/gskssl64.tar.gz
#RUN mkdir -p /opt/mqm/gskit8 && \
#    cd /opt/mqm/gskit8 && \
#    tar -xf /tmp/gskssl64.tar.gz

USER aceuser

ENV ODBCINI=/home/aceuser/odbc.ini
ENV DB2DSDRIVER_CFG_PATH=/home/aceuser/db2dsdriver.cfg


# We're in an internal pipeline
ENV LICENSE=accept

# Would be needed for full DB2 install
# RUN apt-get install -y binutils libnuma1 libaio1

# Switch off the admin REST API for the server run, as we won't be deploying anything after start
RUN sed -i 's/#port: 7600/port: -1/g' /home/aceuser/ace-server/server.conf.yaml

RUN /tmp/deploy-bars.sh /tmp

# Set entrypoint to run the server
ENTRYPOINT ["bash", "-c", "/tmp/init-creds.sh && IntegrationServer -w /home/aceuser/ace-server --no-nodejs"]

#export LD_LIBRARY_PATH=/opt/mqm/gskit8/lib64:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/opt/ibm/ace-12/server/ODBC/dsdriver/odbc_cli/clidriver/lib:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/opt/ibm/ace-12/server/ODBC/dsdriver/odbc_cli/clidriver/lib/icc:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=/opt/ibm/ace-12/server/ODBC/dsdriver/odbc_cli/clidriver/lib/icc/C/icc/icclib:$LD_LIBRARY_PATH
