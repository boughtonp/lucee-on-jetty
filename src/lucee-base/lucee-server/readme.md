# Lucee on Jetty lucee-server directory.

The primary Lucee on Jetty readme is README.TXT in the top-level directory.

This lucee-server directory is where Lucee stores the configuration for the
Lucee Server and the patches when Lucee is updated - by default this directory
is found in lib/ext/lucee-server (alongside the Lucee JARs), but this bundle has
been configured for a more convenient location.

The context directory contains the lucee-server.xml config file for the Lucee
Server Admin, along with other global/server-level files.

The patches directory will contain one or more X.X.X.xxx.lco files - the latest
patch in this directory is the version Lucee will run.

A manual upgrade can be performed by copying a newer .lco file to this directory
and restarting Lucee.
