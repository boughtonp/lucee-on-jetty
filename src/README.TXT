Lucee on Jetty


Description
-----------

Lucee on Jetty is an unzip-and-run Lucee-enabled Jetty server. It does not
require installation, simply extract the files from the zip and run the
start-server script and you have a server running Lucee.

The file structure uses Jetty's home/base directory split - this means:
* The directory jetty-home is an unmodified copy of the latest Jetty release.
* The directory lucee-base contains Lucee JARs and configuration.
(See readme file in lucee-base for further details.)

This bundle was created from the template at:

  https://github.com/boughtonp/lucee-on-jetty


Usage
-----

Unzip to a suitable location.
On Windows, double-click the start-server.bat to start the server.
All other operating systems, execute start-server.sh to start the server.
Pressing Ctrl-C will shutdown the server.

There are README files in many directories. Reading them is highly recommended.

Key points:
* The default port (8080) can be changed in lucee-base/start.ini
* The default webroot is lucee-base/webapps/ROOT
* Instructions for adding more are in lucee-base/webapps/readme.md
* The Lucee web admin for a context is at http://{hostname}/lucee/admin/web.cfm
and the context directories are at lucee-base/webinfs/{lucee-context-label}
* The Lucee server admin is http://{hostname}/lucee/admin/server.cfm and the
server context can be found in lucee-base/lucee-server


Licensing
---------

This Lucee on Jetty bundle is collectively licensed as LGPLv3, with its included
documentation licensed as CC-BY-SA v4.0.

The primary components are licensed as below. These in turn have their own
components - see respective READMEs for details.

Jetty v{JETTY_VERSION}
* Website: http://eclipse.org/jetty
* Source: http://git.eclipse.org/c/jetty
* License: Apache v2.0 (also available under EPL v2)
* Files: jetty-home/*

Lucee v{LUCEE_VERSION}
* Website: http://lucee.org
* Source: https://bitbucket.org/lucee/lucee
* License: LGPLv2
* Files: lucee-base/lib/ext/*



FAQ
---

> What port does it run on?

The HTTP server will run on the port specified by the `jetty.port` setting in
the lucee-base/start.ini config file, and uses the Jetty default of 8080. It can
be changed to any available port. Note that changes to start.ini require a Jetty
restart to be picked up.

> Where is the hostname/aliases set?

Jetty runs on localhost only by default, but can be set to respond to any IP or
hostname. This is configured on a per-context basis, e.g. each host can have its
own context, or multiple virtual host aliases can point to a single context.

The configuration for this is via the webapp context XML config files, which
reside in lucee-base/webapps - see the associated readme for further details.

> Where is the webroot?

The default webroot is lucee-base/webapps/ROOT/
You can add virtual host aliases by editing lucee-base/webapps/ROOT.xml
You can add other webroots (contexts) by copying and changing the XML file.

See the readme in lucee-base/webapps for details of both of these.

> Where are the Lucee logs?

Lucee logs are stored in a context's web config directory - that is in
lucee-base/webinfs/{web-context-label}/logs
(The web-context-label defaults to a unique value for each context. To see - and
change - this label, for all contexts, login to the Lucee Server Admin.)

The logs directory in lucee-base is used by the Jetty instance.

> How is Jetty upgraded?

Download a new Jetty distribution and replace the jetty-home directory with it.

> How is Lucee upgraded?

Use Lucee's own upgrade functionality (i.e. via admin, or an lco patch file).
For major upgrades, replace lucee-base/lib/ext with a new Lucee JAR download.

> I have a question not answered here?

Check the documentation wiki:
  https://github.com/boughtonp/lucee-on-jetty/wiki
  
If the answer is not there, raise an issue:
	https://github.com/boughtonp/lucee-on-jetty/issues


/eof