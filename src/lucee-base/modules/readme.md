# Lucee on Jetty modules directory.

The primary Lucee on Jetty readme is README.TXT in the top-level directory.

Jetty uses modules to group dependenies, libraries, and configuration so that
a single module can be enabled without needing to manually enable all the others
that it uses, and to verify that relevant files exist.

You can read more about modules in the Jetty documentation:
  http://www.eclipse.org/jetty/documentation/current/startup-modules.html

The **lucee.mod** file defines a Lucee module consisting of the other modules
Lucee requires to run, plus a reference to the Lucee JAR.
