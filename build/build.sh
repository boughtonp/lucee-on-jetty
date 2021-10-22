#!/bin/bash

function main ()
{
	[ "$*" == "" ] && { showHelp ; exit ; }

	setupDefaults

	parseOptions "$@"

	validateOptions || { printInfo "Aborting..." ; exit 1 ; }

	printInfo "Building Lucee on Jetty"

	createBundle

	[ -f "$OutputFile" ] || printFatal "No output file found [$OutputFile]"
	printInfo "Build Complete [$OutputFile]"
}


function showHelp ()
{
	cat <<- endhelp
		Lucee on Jetty build script - configures and bundles Lucee with Jetty.

		Usage:
		  $0 OPTION...

		General Options:
		  --help    Shows this help text and exits.
		  --quiet   Only print warnings and errors.
		  --strict  Treat warnings as errors (i.e. stop and emit exit status).

		Build Options:
		  --jetty=PATH      Path of a jetty-home or jetty-distribution archive.
		  --lucee=PATH      Path of a Lucee jar file.
		  --module=PATH     Path of a Jetty module.mod file. (+)
		  --extension=PATH  Path of a Lucee extension.lex file. (+)
		  --output=PATH     Path of bundle, default build/luje-TIMESTAMP.tar

		  Options marked (+) can be specified multiple times for additional files.

		Examples:
		  You must specify at least jetty-home and lucee jar:
		    $0 --jetty=jetty-home-9.4.44.v20210927.zip --lucee=lucee-5.3.8.206.jar

		  When numerous options are present, escaping newlines can assist readability:
		    $0 \\
		     --jetty=jetty-home-9.4.44.v20210927.zip \\
		     --lucee=lucee-light-5.3.8.206.jar \\
		     --extension=../ext/lucee.admin.extension-1.0.0.3.lex \\
		     --extension=../ext/lucee.doc.extension-1.0.0.2.lex \\
		     --output=../out/luje_9444_538.zip

		View "readme.md" in parent directory for more information,
		or see online help at: https://docs.sorcerersisle.com/luje
	endhelp

}

function printDebug   { echo -e "\e[1;97mDEBUG: \e[0;34;47m$*\e[0m" ;}
function printVerbose { [ "$Verbosity" -gt 1 ] && echo -e "\e[32m$*\e[0m" ;}
function printInfo    { [ "$Verbosity" -gt 0 ] && echo "$*" ;}
function printWarn    { echo -e "\e[93mWarning: $*\e[0m" 1>&2 ; [ "$Strictness" -gt 0 ] && exit 1 ;}
function printError   { echo -e "\e[91mError: $*\e[0m" 1>&2 ;}
function printFatal   { printError "$*" ; exit 1 ; }


function setupDefaults ()
{
	BuildId="luje-$(date '+%s')"
	ScriptPath="$(realpath "$0")"
	BuildDir="$(dirname "$ScriptPath")"
	MainDir="$(dirname "$BuildDir")"
	SourceDir="${MainDir}/src"
	WorkingDir="${BuildDir}/${BuildId}"

	Verbosity=1
	Strictness=0
	Debug=0

	JettyFile=
	LuceeFile=
	OutputFile="${BuildDir}/${BuildId}.tar"
	ModuleFiles=("$MainDir/lucee.jetty-module/lucee.mod")
	declare -ga ExtensionFiles
}


function parseOptions ()
{
	while [[ -n "$*" ]]
	do
		case "$1" in
			--        ) break ;;
			--help    ) showHelp ; exit ;;
			--quiet   ) Verbosity=0  ;;
			--verbose ) Verbosity=2  ;;
			--strict  ) Strictness=1 ;;
			--debug   ) Debug=1 ; Verbosity=2 ; Strictness=1  ;;

			--jetty=*     ) JettyFile="$(realpath -m "${1#*=}")"      ;;
			--lucee=*     ) LuceeFile="$(realpath -m "${1#*=}")"      ;;
			--output=*    ) OutputFile="$(realpath -m "${1#*=}")"     ;;
			--module=*    ) ModuleFiles+=("$(realpath -m "${1#*=}")")    ;;
			--extension=* ) ExtensionFiles+=("$(realpath -m "${1#*=}")") ;;

			'' ) printWarn "Empty parameter $# from end." ;;

			* )
				printError "Unknown option \"$1\""
				echo -e "\nSee \"$0 --help\" for valid options."
				exit 1
		esac

		shift
	done

	if [ "$Debug" -gt 0 ]
	then
		printDebug "Verbosity=$Verbosity"
		printDebug "Strictness=$Strictness"
		printDebug "JettyFile=$JettyFile"
		printDebug "LuceeFile=$LuceeFile"
		printDebug "OutputFile=$OutputFile"
		printDebug "ModuleFiles=${ModuleFiles[*]}"
		printDebug "ExtensionFiles=${ExtensionFiles[*]}"
	fi
}


function validateOptions ()
{
	Errors=0

	if [ -z "$JettyFile" ]
	then
		printError "No Jetty file specified. (The --jetty option is required.)"
		Errors=1
	elif [ ! -f "$JettyFile" ]
	then
		printError "Cannot see Jetty file [$JettyFile] - check file exists and has correct permissions."
		Errors=1
	fi

	if [ -z "$LuceeFile" ]
	then
		printError "No Lucee file specified. (The --lucee option is required.)"
		Errors=1
	elif [ ! -f "$LuceeFile" ]
	then
		printError "Cannot see Lucee jar [$LuceeFile] - check file exists and has correct permissions."
		Errors=1
	fi

	if [ ! -d "$SourceDir" ]
	then
		printError "Invalid Source directory [$SourceDir] - check directory exists and has correct permissions."
		Errors=1
	fi

	if [ -f "$OutputFile" ]
	then
		printError "Invalid Output file [$OutputFile] - file already exists."
		Errors=1
	fi

	for CurModule in "${ModuleFiles[@]}"
	do
		if [ ! -f "$CurModule" ]
		then
			printError "Specified module [$CurModule] is not a file, or has incorrect permissions."
			Errors=1
		fi
	done

	for CurExtension in "${ExtensionFiles[@]}"
	do
		if [ ! -f "$CurExtension" ]
		then
			printError "Specified extension [$CurExtension] is not a file, or has incorrect permissions."
			Errors=1
		fi
	done

	return "$Errors"
}


function createBundle ()
{
	mkdir "$WorkingDir" && printInfo "Created working directory [$WorkingDir]"

	cd "$WorkingDir" || printFatal "failed to cd $WorkingDir"
	printVerbose "In directory [$PWD]"


	## 1 - template (jetty-base) ##

	printInfo "1/7 Copy template files "
	cp -r "$SourceDir"/* ./ && printVerbose "    Copied [$SourceDir]"

	mkdir -p "lucee-base/logs" && printVerbose "    Created [lucee-base/logs]"


	## 2 - jetty-home ##

	printInfo "2/7 Extract Jetty"
	if [ "${JettyFile##*.}" = "zip" ]
	then
		unzip -q "$JettyFile" && printVerbose "    Extracted [$JettyFile]"
	else
		tar -xaf "$JettyFile" && printVerbose "    Extracted [$JettyFile]"
	fi
	shopt -s nullglob
	mv jetty-{home,distribution}-* jetty-home
	shopt -u nullglob
	if [ ! -d jetty-home ]; then
		printError "Jetty archive [$JettyFile] did not provide expected jetty-home-{version} or jetty-distribution-{version} directory."
		printInfo "Aborting..."
		exit 1
	fi

	chmod -R +w jetty-home


	## 3 - jetty modules ##

	if [ ${#ModuleFiles[@]} -gt 0 ]
	then
		printInfo "3/7 Copy ${#ModuleFiles[@]} Jetty module(s)"
		ModuleDir=lucee-base/modules/
		mkdir -p "$ModuleDir"
		for CurModule in "${ModuleFiles[@]}"
		do
			if [ -d "$CurModule" ]
			then
				cp -r "$CurModule"/* "$ModuleDir" && printVerbose "    Copied contents of directory [$CurModule]"
			elif [ -f "$CurModule" ]
			then
				cp "$CurModule" "$ModuleDir" && printVerbose "    Copied module [$CurModule]"
				CurModuleDir="${CurModule%.mod}"
				[ -d "$CurModuleDir" ] && cp -r "$CurModuleDir" "$ModuleDir" && printVerbose "    Copied module directory [$CurModuleDir]"
			else
				printWarn "Unknown Module $CurModule"
			fi
		done
	else
		printInfo "3/7 No Jetty modules specified"
	fi


	## 4 - lucee ##

	printInfo "4/7 Copy Lucee jar"
	JarLocation=$(find ./ -name 'lucee_jar_goes_here')
	[ -z "$JarLocation" ] && printFatal "Unable to find target location for Lucee jar"
	cp "$LuceeFile" "$(dirname "$JarLocation")" && printVerbose "    Copied [$LuceeFile]"
	rm "$JarLocation"


	## 5 - lucee extensions ##

	if [ ${#ExtensionFiles[@]} -gt 0 ]
	then
		printInfo "5/7 Copy ${#ExtensionFiles[@]} Lucee extension(s)"
		ExtensionDir=lucee-base/lucee-server/deploy/
		mkdir -p "$ExtensionDir"
		for CurExtension in "${ExtensionFiles[@]}"
		do
			if [ -d "$CurExtension" ]
			then
				cp -r "$CurExtension"/*.lex "$ExtensionDir" && printVerbose "    Copied *.lex from directory [$CurExtension]"
			elif [ -f "$CurExtension" ]
			then
				cp "$CurExtension" "$ExtensionDir" && printVerbose "    Copied extension [$CurExtension]"
			else
				printWarn "Unknown extension [$CurExtension]"
			fi
		done
	else
		printInfo "3/7 No Lucee extensions specified"
	fi


	## 6 - readme ##

	printInfo "6/7 Update readme versions"
	JettyVersion=$(echo "$JettyFile" | grep -oP 'jetty-(distribution|home)-\K[\d.]*(?=(\.M\d|\.v\d+|)\.(zip|tgz|tar(\.gz)?)$)')
	LuceeVersion=$(echo "$LuceeFile" | grep -oP 'lucee-(light-)?\K[\d.]*(?=\.jar$)')
	printVerbose "    Jetty Version [$JettyVersion]"
	printVerbose "    Lucee Version [$LuceeVersion]"
	[ -z "$JettyVersion" ] && printWarn "Failed to read version from filename [$JettyFile]"
	[ -z "$LuceeVersion" ] && printWarn "Failed to read version from filename [$LuceeFile]"
	sed "s/{JETTY_VERSION}/$JettyVersion/g" < README.TXT > README.TMP
	sed "s/{LUCEE_VERSION}/$LuceeVersion/g" < README.TMP > README.TXT
	rm README.TMP


	## 7 - archive ##

	printInfo "7/7 Create bundle & cleanup"
	mkdir -p "$(dirname "$OutputFile")"

	if [ "${OutputFile##*.}" = "zip" ]
	then
		if [ -n "$(type -t zip)" ]
		then
			zip "$OutputFile" -- * && printVerbose "    Compressed [$OutputFile] with zip"
		elif  [ -n "$(type -t 7z)" ]
		then
			7z a "$OutputFile" -- * > /dev/null && printVerbose "    Compressed [$OutputFile] with 7z"
		else
			printFatal "No 'zip' or '7z' command; cannot create zip file"
		fi
	else
		tar -caf "$OutputFile" -- * && printVerbose "    Compressed [$OutputFile] with tar"
	fi

	cd .. || printFatal "failed to cd .."

	printVerbose "    Removing working directory [$WorkingDir]"
	rm -r "$WorkingDir" || printWarn "Failed to remove [$WorkingDir]"
}

main "$@"
