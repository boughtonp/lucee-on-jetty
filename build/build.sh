#!/bin/bash

echo -e "\n\e[1;97mBuilding Lucee on Jetty!\e[0m\n"

JettyFile=$(echo "$@" | perl -ne 'print $_ =~ /--jetty=(\S+)/')
LuceeFile=$(echo "$@" | perl -ne 'print $_ =~ /--lucee=(\S+)/')
Errors=0

if [ -z "$JettyFile" ]; then
	echo "Specify --jetty=/path/to/jetty-distribution.tgz"
	Errors=1
fi

if [ -z "$LuceeFile" ]; then
	echo "Specify --lucee=/path/to/lucee.jar"
	Errors=1
fi

if [ ! -f "$JettyFile" ]; then
	echo "Invalid Jetty file [$JettyFile]"
	Errors=1
fi

if [ ! -f "$LuceeFile" ]; then
	echo "Invalid Lucee file [$LuceeFile]"
	Errors=1
fi

if [ $Errors -ne 0 ]; then
	echo "Aborting..."
	exit
fi


cd "$(dirname "$0")" || { echo "ERROR: cd failed" ; exit ; }
echo "In build directory [$PWD]"

WorkingDir=luje-$(date '+%s')
mkdir "$WorkingDir"

cd "$WorkingDir" || { echo "ERROR: cd failed" ; exit ; }
echo "In working directory [$PWD]"

echo "1/5 Copying template files"
cp -r ../../src/* ./

echo "2/5 Extracing $JettyFile"
if [ "${JettyFile##*.}" = "zip" ]
then
	unzip -q "$JettyFile"
else
	tar -xzf "$JettyFile"
fi
shopt -s nullglob
mv jetty-{home,distribution}-* jetty-home
if [ ! -d jetty-home ]; then
	echo "Error: Jetty file [$JettyFile] did not provide expected jetty-home-{version} or jetty-distribution-{version} directory."
	echo "Aborting..."
	exit
fi

echo "3/5 Extracing $LuceeFile"
cp "$LuceeFile" lucee-base/modules/lucee/lib/
rm lucee-base/modules/lucee/lib/lucee_jar_goes_here

JettyVersion=$(echo "$JettyFile" | perl -ne 'print $_ =~ /jetty-(?:distribution|home)-([\d.]*)(?:(\.M\d)|\.v\d+)\.(?:zip|tgz|tar\.gz)$/')
LuceeVersion=$(echo "$LuceeFile" | perl -ne 'print $_ =~ /lucee-(?:light-)?([\d.]*).jar$/')
echo "4/5 Setting versions [$JettyVersion] and [$LuceeVersion]"
[ -z "$JettyVersion" ] && echo "WARNING: failed to read version from filename [$JettyFile]"
[ -z "$LuceeVersion" ] && echo "WARNING: failed to read version from filename [$LuceeFile]"
sed "s/{JETTY_VERSION}/$JettyVersion/g" < README.TXT > README.TMP
sed "s/{LUCEE_VERSION}/$LuceeVersion/g" < README.TMP > README.TXT
rm README.TMP

echo "5/5 Creating dist/$WorkingDir.tgz"
mkdir -p ../../dist
tar -czf "../../dist/$WorkingDir.tgz" -- *
cd .. || { echo "ERROR: cd failed" ; exit ; }
rm -r "$WorkingDir"

echo -e "\n\e[1;97mBuild Complete!\e[0m\n"
