#!/bin/sh

################################
#
# 01fo-dev-sys-backup.sh
#
# @changed: 2008-08-10
#
# @author Daniel Lindh <daniel@fareoffice.com>
################################

DOW=`date +%u`

######################3
# S� slipper vi "Removing leading `/' from member names" påar
cd /

################################
# Backup
tar czf /opt/fareoffice/AutomaticBackups/develop/fo-dev-wiki/day-$DOW-fo-dev-wiki.tar.gz --exclude NoBackup opt/twiki
