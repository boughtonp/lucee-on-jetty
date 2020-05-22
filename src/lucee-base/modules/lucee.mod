#
# Lucee Module
#

[description]
Enables Lucee CFML engine.

[depend]
http
jsp
rewrite

[lib]
modules/lucee/lib/**.jar

[ini]
modules/lucee/etc/lucee-rewrite-rules.xml
modules/lucee/etc/lucee-global-webapp-common.xml

[files]
basehome:modules/lucee/lucee-server/
basehome:modules/lucee/webapps/
basehome:modules/lucee/webinfs/