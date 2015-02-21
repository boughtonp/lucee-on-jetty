# Lucee on Jetty etc directory.

The primary Lucee on Jetty readme is README.TXT in the top-level directory.

This directory is where Jetty settings can be overridden.

The **lucee-servlets.xml** file contains the servlet and servlet-mapping
settings for the Lucee CFML and REST servlets. It is included in web context
configuration using Jetty's overrideDescriptor functionality.

The **rewrite-rules.xml** file configures Jetty's rewrite handler. It applies
to all contexts, but rules can be grouped per virtualhost. Jetty's documentation
is at: http://www.eclipse.org/jetty/documentation/current/rewrite-handler.html
