#!/bin/sh

# Separate parameters (thanks @felipek)
for param in $@; do eval "${param%%=*}=${param##*=}"; done

# If have a specific build
if [ ! -z "${bundle}" ]; then
	if [ -d ./Bundles/"${bundle}"/ ]; then

		# Clean all build folder
		rm -Rf ./build/
		printf "Build folder deleted.\n"

		# Clean project
		sh clean_project.sh
		printf "Project cleaned.\n"

		# Move all icons and splashs to root directory
		# iOS
		cp ./Bundles/"${bundle}"/app/iphone/appicon.png ./Resources/iphone/
		cp ./Bundles/"${bundle}"/app/iphone/appicon@2x.png ./Resources/iphone/
		cp ./Bundles/"${bundle}"/app/iphone/Default.png ./Resources/iphone/
		cp ./Bundles/"${bundle}"/app/iphone/Default@2x.png ./Resources/iphone/
		printf "iOS resources copied.\n"

		# Android
		cp ./Bundles/"${bundle}"/app/android/appicon.png ./Resources/android/
		cp ./Bundles/"${bundle}"/app/android/default.png ./Resources/android/
		printf "Android resources copied.\n"

		# Move Bundle file to root directory
		cp ./Bundles/"${bundle}"/app/tiapp.xml ./
		printf "Bundle (${bundle}) resources copied.\n"

		# Copy Images folder
		cp -R ./Bundles/"${bundle}"/images/ ./Resources/images/
		printf "Images copied.\n"

		# Copy Data folder
		cp -R ./Bundles/"${bundle}"/data/ ./Resources/data/
		printf "Data copied.\n"

	else
		printf "The bundle ("${bundle}") not exists.\n"
		exit 1
	fi
else
	printf "No one file was copied.\n"
fi

# Compile CoffeeScript
# Default
coffee -c -o ./Resources/lib/ ./Resources/lib/*.coffee
coffee -c -o ./Resources/ui/ ./Resources/ui/*.coffee
coffee -c -o ./Resources/ ./Resources/*.coffee

# Android
coffee -c -o ./Resources/android/ ./Resources/android/*.coffee
coffee -c -o ./Resources/android/ui/ ./Resources/android/ui/*.coffee
coffee -c -o ./Resources/android/lib/ ./Resources/android/lib/*.coffee

# iPhone
coffee -c -o ./Resources/iphone/ ./Resources/iphone/*.coffee
coffee -c -o ./Resources/iphone/ui/ ./Resources/iphone/ui/*.coffee
coffee -c -o ./Resources/iphone/lib/ ./Resources/iphone/lib/*.coffee

printf "CoffeeScript compiled\n"
printf "Running application\n"

# Run Application
if [ ! -z "${platform}" ] && [ "${platform}" == "android" ]; then
	make deploy platform="${platform}"
else
	make run
fi