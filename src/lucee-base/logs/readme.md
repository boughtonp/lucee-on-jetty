# Lucee on Jetty logs directory.

The primary Lucee on Jetty readme is README.TXT in the top-level directory.

This directory is where Jetty will place log files, including stderr and stdout.

For details on Jetty logging, see the Jetty documentation:
  http://www.eclipse.org/jetty/documentation/current/configuring-logging.html


Lucee log files are located within a web context's configuration directory, that
is, within `lucee-base/webinfs/{web-context-label}/logs`
