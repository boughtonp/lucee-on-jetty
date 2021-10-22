#!/bin/bash

echo -e "\n\e[1;97mWelcome to Lucee on Jetty!\e[0m\n"

cd "$(dirname "$0")/lucee-base" || { echo "Failed to enter base directory." ; exit 1 ; }
echo "In directory [$PWD]"

echo -e "Starting Jetty... (Use Ctrl-C to shutdown server.)\n"
java -jar ../jetty-home/start.jar

echo -e "\nJetty stopped.\n"
read -rs -n 1 -p "Press any key to continue..."