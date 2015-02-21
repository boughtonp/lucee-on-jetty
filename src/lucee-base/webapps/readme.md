# Lucee on Jetty webapps directory.

The primary Lucee on Jetty readme is README.TXT in the top-level directory.
The default Jetty webapps readme is README.TXT in jetty-home/webapps

This webapps directory is where Jetty WebApp Contexts are located.

There is one context by default - ROOT.xml - which listens on localhost and has
its resourceBase (webroot) set to the lucee-base/webapps/ROOT directory.

These context XML config files work as per Jetty documentation, with the
addendum that invoking Lucee means including the lucee-servlets.xml
configuration via the overrideDescriptor setting:

	<Set name="overrideDescriptor"><SystemProperty name="jetty.base" default="."/>/etc/lucee-servlets.xml</Set>


## Adding a new context

Create a new XML file from the ROOT.xml, set the resourceBase appropriately, and
specify the virtual host aliases that the context responds to.

Jetty is configured to automatically deploy new contexts, without needing to
restart the Jetty server. For details on this, see the Jetty Documentation
section below.


## Adding a virtual host to a context

A context will respond to the hostnames specified in its virtual host aliases
section. The default ROOT context has been configured to run only on localhost,
but can be reconfigured if desired.

If a context does not have any virtual hosts configured, it will respond for any
hostname or IP which points to the machine.

Details on how to configure virtual hosts are available at:
  http://www.eclipse.org/jetty/documentation/current/configuring-virtual-hosts.html


## Jetty Documentation

There is a README.txt in jetty-home/webapps which provides some information on
webapp deployment, or a more complete explanation is available online:
  http://www.eclipse.org/jetty/documentation/current/configuring-deployment.html
