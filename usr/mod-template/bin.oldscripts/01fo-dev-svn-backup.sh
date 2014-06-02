#!/bin/sh

################################
#
# 01fo-dev-svn-backup.sh
#
# @changed: 2008-08-10
#
# @author Daniel Lindh <daniel@fareoffice.com>
################################

DOW=`date +%u`

######################3
# S� slipper vi "Removing leading `/' from member names" p� tar
cd /

clamscan -r /projects

svnadmin dump /projects/fp > /opt/fareoffice/AutomaticBackups/develop/fo-dev-svn/day-$DOW-fo-dev-svn-fp.dump
svnadmin dump /projects/fo > /opt/fareoffice/AutomaticBackups/develop/fo-dev-svn/day-$DOW-fo-dev-svn-fo.dump

###############
# Backup
tar czf /opt/fareoffice/AutomaticBackups/develop/fo-dev-svn/day-$DOW-fo-dev-svn.tar.gz \
  opt/fareoffice/AutomaticBackups/develop/fo-dev-svn/day-$DOW-fo-dev-svn-fp.dump \
  opt/fareoffice/AutomaticBackups/develop/fo-dev-svn/day-$DOW-fo-dev-svn-fo.dump