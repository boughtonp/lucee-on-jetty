Lucee on Jetty

* Version:       0.7
* License:       LGPLv3
* Homepage:      https://www.sorcerersisle.com/software/luje
* Documentation: https://docs.sorcerersisle.com/luje
* Repository:    https://code.sorcerersisle.com/luje.git
* Issues:        https://github.com/boughtonp/lucee-on-jetty/issues


Description
-----------

Lucee on Jetty is a project to provide:
* a Jetty module for running the Lucee CFML engine
* sensible defaults configured for Lucee and Jetty
* documentation of what has been configured and why
* a reference guide for how to perform common tasks

This repository contains the template for bundling Lucee with Jetty. It uses
Jetty's home/base functionality to simplify the process and avoid the need to
modify the Jetty files, and uses a module to keep Lucee configuration discrete.


Requirements
------------

Lucee on Jetty bundles are built with a Bash script.
Whilst the resulting bundle requires a JVM to run, the build process does not.

Thus, the minimum requirements are GNU Bash and GNU Coreutils (or compatible).

Git is the easiest way to obtain the lucee.jetty-module submodule.

If not already installed, these are available via your package manager.

(Windows users can install Git for Windows to obtain all of these.)


Getting Started
---------------

It is not required to build Lucee on Jetty yourself - if all you want 
is to run Lucee on Jetty, you can download a pre-built package from
https://www.sorcerersisle.com/software/luje

If `lucee.jetty-module` directory is empty, either run `git submodule update`
to have Git download the files; or manually download and copy them from
https://code.sorcerersisle.com/lucee.jetty-module 

Run `build/build.sh --help` to see the various options and example usage.


Licensing & Credits
-------------------

This project is available under the terms of the LGPLv3 license.
See license.txt to understand your rights and obligations.

Lucee on Jetty is created and maintained by Peter Boughton.

This repository does not contain Lucee or Jetty themselves; these have their
own licenses (Lucee: LGPLv2; Jetty: Apache License 2.0 or EPLv2).


Contributing
------------

This project was created to provide a ready-to-run Lucee package for 
anyone who prefers Jetty to Tomcat

Contributions are welcome, but please discuss first (either by 
raising an issue or sending an email).


/eof