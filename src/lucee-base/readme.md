# Lucee on Jetty lucee-base directory.

For the primary Lucee on Jetty readme, see README.TXT in the parent directory.

This lucee-base directory uses the split jetty-home/jetty-base functionality
available in Jetty 9, to allow configuration of Lucee against an unmodified 
Jetty instance. For more information on jetty-base see the Jetty documentation
at http://www.eclipse.org/jetty/documentation/current/startup-base-and-home.html

This file contains information about the following:
* The structure and purpose of the files and directories here.
* Jetty and Lucee configurations which have been made.

For more specific information, check for a readme in the relevant directory.
(If there is no readme, check the Jetty documentation for further details.)


## Directories and files

	readme.md    - this file.
	start.ini    - Jetty startup modules & configuration.
	etc          - Jetty configuration overrides.
	 ~ lucee-servlets.xml - Lucee CFML Servlet configuration.
	 ~ rewrite-rules.xml - Jetty URL rewrite rules. 
	lib/ext      - Lucee's JAR files.
	logs         - Jetty's log files are created here.
	lucee-server - Lucee's server context and patches go here.
	modules      - Additional Jetty module files.
	 ~ lucee.mod - Lucee module for Jetty.
	resources    - Jetty resource files.
	 ~ jetty-logging.properties - Jetty logging configuration
	webapps      - Jetty looks for webapp contexts here.
	 ~ ROOT.xml - the XML config file for the default webapp context.
	webinfs      - Lucee's webapp context configuration and log files.


## Jetty configuration

* The `start.ini` file lists the relevant built-in modules plus `modules/lucee.mod`
* The `etc/rewrite-rules.xml` file is loaded by start.ini and rewrites *.cfm to enable path info.
* The `etc/lucee-servlets.xml` file is loaded via the overrideDescriptor setting 
in a webapp XML config file, and maps *.cfm and *.cfc to Lucee's CFMLServlet.


## Lucee configuration

* The `lucee-server-directory` parameter is set to use `lucee-base/lucee-server` 
instead of the `lucee-base/lib/ext/lucee-server` default.
* The `lucee-web-directory` parameter is set to use `lucee-base/webinfs/{web-context-label}` 
instead of `lucee-base/webapps/{context}/WEB-INF/lucee`
