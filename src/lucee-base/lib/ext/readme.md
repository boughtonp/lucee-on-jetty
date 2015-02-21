# Lucee on Jetty lib/ext directory.

The primary Lucee on Jetty readme is README.TXT in the top-level directory.

This lib/ext directory contains the Lucee JAR files. Jetty's ext module looks in
this directory (and any subdirectories) for *.jar and automatically adds them to
the classpath.

Jetty's documentation for this is at:
  http://www.eclipse.org/jetty/documentation/current/startup-classpath.html
