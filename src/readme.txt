Lucee on Jetty


Description
-----------

Lucee on Jetty is an unzip-and-run Lucee-enabled Jetty server. It does not
require installation, simply extract the files from the zip, run the
start-server script, and you have a Jetty server running Lucee.

The file structure uses Jetty's home/base directory split - this means:
* The directory jetty-home is an unmodified copy of the latest Jetty release.
* The directory lucee-base contains all configuration and the Lucee JAR.

Documentation is provided in docs.pdf and online at https://docs.sorcerersisle.com/luje

This bundle was built using the template at https://code.sorcerersisle.com/luje


Requirements
------------

The requirements for running a Lucee on Jetty bundle are that of the
individual components - namely, a supported Java VM.

For Jetty 9.x and Lucee 5.x this means a JRE at v8 or v11.

Jetty 10.x requires a v11 JRE.

If in doubt, visit https://adoptopenjdk.net and follow the instructions
to get the latest OpenJDK 11 (LTS) for your operating system.


Usage
-----

Unzip to a suitable location.
On Windows, double-click the start-server.bat to start the server.
All other operating systems, execute start-server.sh to start the server.
Pressing Ctrl-C will shutdown the server.

Browse to http://localhost:8080/ to confirm it is working.

See docs.pdf for details of what is configured, what the various files and
directories are for, etc.

Quick points:
* The default webroot is lucee-base/webapps/ROOT
* The default port (8080) can be changed in lucee-base/start.ini
* The Lucee web admin for a context is at http://{hostname}/lucee/admin/web.cfm
and the context directories are at lucee-base/webinfs/{lucee-context-label}
* The Lucee server admin is http://{hostname}/lucee/admin/server.cfm and the
server context can be found in lucee-base/lucee-server


Licensing
---------

This Lucee on Jetty bundle is collectively licensed as LGPLv3.

The primary components are licensed as below. These in turn have their own
components - see respective READMEs for details.

Jetty v{JETTY_VERSION}
* Website: https://eclipse.org/jetty
* Source: https://github.com/eclipse/jetty.project
* License: Apache v2.0 (also available under EPL v2)
* Files: jetty-home/*

Lucee v{LUCEE_VERSION}
* Website: https://www.lucee.org
* Source: https://bitbucket.org/lucee/lucee
* License: LGPLv2
* Files: lucee-base/modules/lucee/lucee*.jar lucee-base/lucee-server/*


