localizations:
	flutter gen-l10n --arb-dir ./l10n/app --output-dir ./core/lib/src/localizations/generated --template-arb-file app_en.arb --output-localization-file app_localizations.dart --output-class AppLocalizations --no-synthetic-package
	flutter gen-l10n --arb-dir ./l10n/canteen --output-dir ./core/lib/src/localizations/generated --template-arb-file canteen_en.arb --output-localization-file canteen_localizations.dart --output-class CanteenLocalizations --no-synthetic-package
	flutter gen-l10n --arb-dir ./l10n/explore --output-dir ./core/lib/src/localizations/generated --template-arb-file explore_en.arb --output-localization-file explore_localizations.dart --output-class ExploreLocalizations --no-synthetic-package
	flutter gen-l10n --arb-dir ./l10n/settings --output-dir ./core/lib/src/localizations/generated --template-arb-file settings_en.arb --output-localization-file settings_localizations.dart --output-class SettingsLocalizations --no-synthetic-package
	flutter gen-l10n --arb-dir ./l10n/feedback --output-dir ./core/lib/src/localizations/generated --template-arb-file feedback_en.arb --output-localization-file feedback_localizations.dart --output-class FeedbackLocalizations --no-synthetic-package

run_generator: 
	dart run build_runner build --delete-conflicting-outputs

generate_splash_screen:
	dart run flutter_native_splash:create

setup_mapbox:
	sh scripts/mapbox_setup.sh ${MAPBOX_ACCESS_TOKEN}

update_pods:
	cd ios && pod repo update && pod install && cd ..