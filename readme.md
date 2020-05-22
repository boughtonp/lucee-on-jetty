Lucee on Jetty

* Version:       0.6
* License:       LGPLv3
* Homepage:      https://www.sorcerersisle.com/software/luje
* Documentation: https://docs.sorcerersisle.com/luje
* Repository:    https://github.com/boughtonp/lucee-on-jetty.git
* Issues:        https://github.com/boughtonp/lucee-on-jetty/issues


Description
-----------

Lucee on Jetty is a project offering a Lucee package that is easy to use and
provides a fully functional & capable web server, whilst also documenting how
everything has been done so it can be understood and adapted as needed.

This repository contains the template for bundling Lucee with Jetty. It uses
Jetty's home/base functionality to simplify the process and avoid the need to
modify the Jetty files.


How to build
------------

The build directory contains a bash build script, but the basic process is:

  1. cp src -> {target}
  2. unzip jetty-X.zip -> {target}/jetty-home
  3. cp lucee-X.jar -> {target}/modules/lucee/lib
  4. update versions in {target}/README.TXT
  5. zip {target} lucee-on-jetty.zip

That's all there is to it.


Licensing
---------

Lucee on Jetty is a project created and maintained by Peter Boughton, licensed
under the LGPLv3, aside from the documentation and wiki which is CC BY-SA v4.0.

This repository does not contain Lucee or Jetty themselves; these have their
own licenses (Lucee: LGPLv2; Jetty: Apache License 2.0 or EPLv2).


/eof