Lucee on Jetty


Description
-----------

Lucee on Jetty is a project to provide a Lucee package that is easy to use and
provides a fully functional & capable web server, with extensive documentation
on how everything has been done, so it can be understood and adapted as needed.

This repository contains the template for bundling Lucee with Jetty. It uses
Jetty's home/base functionality to simplify the process and avoid the need to
modify the Jetty files.

The project's homepage, including links to download the bundles, is at:

  http://sorcerersisle.com/projects:lucee-on-jetty


How to build
------------

The build directory contains a bash build script, but the basic process is:

  1) cp src -> {target}
  2) unzip jetty-X.zip -> {target}/jetty-home
  3) unzip lucee-jars.zip -> {target}/lucee-base/lib/ext/
  4) update versions in {target}/README.TXT
  5) zip {target} lucee-on-jetty.zip

That's all there is to it.


Licensing
---------

Lucee on Jetty is a project created and maintained by Peter Boughton, licensed
under the LGPLv3, aside from the documentation and wiki which is CC BY-SA v4.0.

This repository does not contain Lucee or Jetty themselves; these have their 
own licenses (Lucee: LGPLv2; Jetty: Apache License 2.0 or EPLv2).


/eof