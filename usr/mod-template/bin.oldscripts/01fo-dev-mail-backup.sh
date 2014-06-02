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
# S� slipper vi "Removing leading `/' from member names" p� tar
cd /

###############
# Backup
tar czf /opt/fareoffice/AutomaticBackups/develop/fo-dev-mail/day-$DOW-fo-dev-mail.tar.gz \
--exclude fareofficefares.com \
usr/opt/kerio