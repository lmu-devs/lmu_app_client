generate_localizations:
	flutter gen-l10n

run_generator: 
	dart run build_runner build --delete-conflicting-outputs

setup_mapbox:
	sh scripts/mapbox_setup.sh ${MAPBOX_ACCESS_TOKEN}

update_pods:
	cd ios && pod repo update && pod install && cd ..