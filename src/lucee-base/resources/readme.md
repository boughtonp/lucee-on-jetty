# Lucee on Jetty resources directory.

The primary Lucee on Jetty readme is README.TXT in the top-level directory.

The resources directory is where Jetty looks for logging configuration, in the
form of either jetty-logging.properties or logging.properties files.

You can read more about logging in the Jetty documentation:
  http://eclipse.org/jetty/documentation/current/configuring-logging.html

The **jetty-logging.properties** file instructs Lucee to use the StdErrLog class 
for its logging, resulting in stdout and stderr being redirected to a log file 
in the lucee-base/logs directory.