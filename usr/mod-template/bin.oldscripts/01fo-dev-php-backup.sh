#!/bin/sh

################################
#
# 01fo-dev-php-backup.sh
#
# @todo: mailbackup st�nga ner keiro?
#
# @changed: 2008-08-10
#
# @author Daniel Lindh <daniel@fareoffice.com>
################################

DOW=`date +%u`

######################3
# S� slipper vi "Removing leading `/' from member names" p� tar
cd /

################################
# Backup
tar czf /opt/fareoffice/AutomaticBackups/develop/fo-dev-php/day-$DOW-fo-dev-php.tar.gz \
--exclude NoBackup \
opt/RootLive
