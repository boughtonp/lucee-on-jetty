# Lucee on Jetty webinfs directory.

The primary Lucee on Jetty readme is README.TXT in the top-level directory.

This webinfs directory contains the configuration for web contexts which Lucee
has been enabled for - by default this would be found in a WEB-INF/lucee
directory in each context's webroot (resourceBase), but this bundle has been
configured to place them here instead.
(Configuration is done via the CFMLServlet `lucee-web-directory` parameter in
the `etc/lucee-servlets.xml` file.)

Each Jetty context that Lucee is enabled for will have its own directory, named
as the lucee-context-label - this defaults to a unique hash but can be changed
in Lucee Server Admin.
