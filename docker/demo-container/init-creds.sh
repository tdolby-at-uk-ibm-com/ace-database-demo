#!/bin/bash
#
# Copyright (c) 2020 Open Technologies for Integration
# Licensed under the MIT license (see LICENSE for details)
#


mqsisetdbparms -w /home/aceuser/ace-server -n odbc::DB2CLOUD -u $DB_USER -p $DB_PASSWORD
mqsisetdbparms -w /home/aceuser/ace-server -n jdbc::db2cloud -u $DB_USER -p $DB_PASSWORD
