generate_localizations:
	flutter gen-l10n

run_generator: 
	dart run build_runner build --delete-conflicting-outputs
