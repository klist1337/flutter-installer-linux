FLUTTER_HOME=/goinfre/$USER/flutter
ANDROID_STUDIO_HOME=/goinfre/$USER/android-studio
ANDROID_STUDIO_LINK=""


BLUE=$'\033[0;34m'
RED=$'\033[0;91m'
BOLD=$'\033[1;31m'
NC=$'\033[0;39m'


############################# INSALLING FLUTTER #############################

if [ -f "$FLUTTER_HOME/bin/flutter" ]

then
	echo $RED "flutter already installed" $NC

else
	printf "$BOLD Flutter isn't found. Do you want to install it ? (y/n) $NC"

	read -n 1 answer
	if [ $answer != "y" ]
	then
		exit 0
	fi

	mkdir -p $FLUTTER_HOME
	echo $BLUE "\ninstalling flutter..."$NC

	# cloning flutter repo
	git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_HOME &> /dev/null

	echo $BLUE "flutter precache..." $NC
	flutter precache &> /dev/null


fi


############################# INSALLING ANDROID STUDIO #############################
# Define the function to get the Android Studio download link
get_android_studio_link() {
    ANDROID_STUDIO_LINK="https://dl.google.com/dl/android/studio/ide-zips/2024.2.1.11/android-studio-2024.2.1.11-linux.tar.gz"

    if [ -z "$ANDROID_STUDIO_LINK" ]; then
        echo "Android Studio link not found"
        exit 1
    fi
}

# Check if Android Studio is already installed
if [ -d "$ANDROID_STUDIO_HOME/android-studio" ]; then
    echo "Android Studio is already installed"
else
    read -p "Android Studio isn't found. Do you want to install it? (y/n) " answer
    if [ "$answer" != "y" ]; then
        exit 0
    fi

    get_android_studio_link

    mkdir -p "$ANDROID_STUDIO_HOME"
    echo "Downloading Android Studio..."
    wget -O "$ANDROID_STUDIO_HOME/android-studio.tar.gz" "$ANDROID_STUDIO_LINK"

    echo "Extracting Android Studio..."
    tar -xzf "$ANDROID_STUDIO_HOME/android-studio.tar.gz" -C "$ANDROID_STUDIO_HOME"
    ###rm "$ANDROID_STUDIO_HOME/android-studio.tar.gz"

    echo "Android Studio installed successfully"
    "$ANDROID_STUDIO_HOME/android-studio/bin/studio.sh" &
fi

