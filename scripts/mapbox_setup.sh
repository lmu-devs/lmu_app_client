NETRC_FILE="$HOME/.netrc"
MAPBOX_AUTH="api.mapbox.com"
MAPBOX_USERNAME="mapbox"
MAPBOX_KEY=$1

# Check if netrc file exists
if test -f "$NETRC_FILE"; then
    # Append mapbox authentication entry
    echo "\nmachine $MAPBOX_AUTH\nlogin $MAPBOX_USERNAME\npassword $MAPBOX_KEY" >> "$NETRC_FILE"
    echo "Mapbox key added to $NETRC_FILE"
else
    # Create netrc file and add mapbox authentication entry
    echo -e "machine $MAPBOX_AUTH\nlogin $MAPBOX_USERNAME\npassword $MAPBOX_KEY" > "$NETRC_FILE"
    chmod 600 "$NETRC_FILE"
    echo "Netrc file created with Mapbox token: $NETRC_FILE"
fi

GRADLE_FILE="$HOME/.gradle/gradle.properties"
MAPBOX_TOKEN="SDK_REGISTRY_TOKEN"

# Check if gradle.properties file exists
if test -f "$GRADLE_FILE"; then
    # Check if mapbox authentication entry exists
    if grep -q "$MAPBOX_TOKEN" "$GRADLE_FILE"; then
        # Update the mapbox authentication entry
        sed -i.bak "/$MAPBOX_TOKEN/ s/^$MAPBOX_TOKEN=.*/$MAPBOX_TOKEN=$MAPBOX_KEY/" "$GRADLE_FILE"
        echo "Mapbox key updated in $GRADLE_FILE"
    else
        # Append mapbox authentication entry
        echo "\n$MAPBOX_TOKEN=$MAPBOX_KEY" >> "$GRADLE_FILE"
        echo "Mapbox key added to $GRADLE_FILE"
    fi
else
    # Create gradle.properties file and add mapbox authentication entry
    echo "$MAPBOX_TOKEN=$MAPBOX_KEY" > "$GRADLE_FILE"
    chmod 755 "$GRADLE_FILE"
    echo "gradle.properties file created with Mapbox token: $GRADLE_FILE"
fi
