#!/bin/sh

################################
#
# 01fo-dev-mail-backup.sh
#
# @todo: mailbackup st�nga ner keiro?
#
# @changed: 2008-08-10
#
# @author Daniel Lindh <daniel@fareoffice.com>
################################

DOW=`date +%u`

######################3
# S�lipper vi "Removing leading `/' from member names" p�ar
cd /

################################
# Backup
tar czf /opt/backup/AutomaticBackups/develop/fo-dev-file/day-$DOW-fo-dev-file-Document.tar.gz opt/data/users/Document/
tar czf /opt/backup/AutomaticBackups/develop/fo-dev-file/day-$DOW-fo-dev-file-Home.tar.gz --exclude NoBackup opt/data/users/home

