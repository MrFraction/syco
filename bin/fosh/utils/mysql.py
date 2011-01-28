#! /usr/bin/env python

# Example
# MysqlProperties("fosh", "10.0.0.2", "root", "xxxx", "fosh_stable", ["127.0.0.1", "localhost"])

class MysqlProperties:
  pool_name=""
  jdbc_name=""
  server=""
  user=""
  password=""
  database=""
  
  # Mysql user_specification IE. 'root'@'localhost'
  user_spec=""
  
  # Mysql user_specification with identified by IE. 'root'@'localhost' IDENTIFIED BY 'PASS'
  user_spec_identified_by=""

  # Used as a password alias in glassfish
  password_alias=""  
  
  def __init__(self, name, server, user, password, database, clients=[]):
    self.pool_name="mysql_" + name
    self.jdbc_name="jdbc/" + name
    self.server=server
    self.user=user
    self.password_alias="mysql_" + name
    self.password=password
    self.database=database
    
    for client in clients:
      if (len(self.user_spec) > 0):
        self.user_spec+=","
      self.user_spec+="'" + self.user + "'@'" + client + "'"

    for client in clients:
      if (len(self.user_spec_identified_by) > 0):
        self.user_spec_identified_by+=","
      self.user_spec_identified_by+="'" + self.user + "'@'" + client + "' IDENTIFIED BY '" + self.password + "'"
    