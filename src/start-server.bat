@ECHO OFF

@ECHO.
@ECHO * Welcome to Lucee on Jetty! *
@ECHO.

PUSHD "%~dp0%lucee-base"
@ECHO In lucee-base directory [%cd%]

@ECHO "Starting Jetty... (Use Ctrl-C to shutdown server.)"
@ECHO.
java -jar ../jetty-home/start.jar

POPD

@ECHO.
@ECHO Jetty stopped.
@ECHO.

PAUSE