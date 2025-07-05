# Include FVM setup and check logic
include fvm.mk

# --- Main Targets ---
.PHONY: localizations run_generator generate_splash_screen update_pods love

localizations: check_fvm_info
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/app --output-dir ./core/lib/src/localizations/generated --template-arb-file app_en.arb --output-localization-file app_localizations.dart --output-class AppLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/calendar --output-dir ./core/lib/src/localizations/generated --template-arb-file calendar_en.arb --output-localization-file calendar_localizations.dart --output-class CalendarLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/canteen --output-dir ./core/lib/src/localizations/generated --template-arb-file canteen_en.arb --output-localization-file canteen_localizations.dart --output-class CanteenLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/explore --output-dir ./core/lib/src/localizations/generated --template-arb-file explore_en.arb --output-localization-file explore_localizations.dart --output-class ExploreLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/wishlist --output-dir ./core/lib/src/localizations/generated --template-arb-file wishlist_en.arb --output-localization-file wishlist_localizations.dart --output-class WishlistLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/settings --output-dir ./core/lib/src/localizations/generated --template-arb-file settings_en.arb --output-localization-file settings_localizations.dart --output-class SettingsLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/feedback --output-dir ./core/lib/src/localizations/generated --template-arb-file feedback_en.arb --output-localization-file feedback_localizations.dart --output-class FeedbackLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/home --output-dir ./core/lib/src/localizations/generated --template-arb-file home_en.arb --output-localization-file home_localizations.dart --output-class HomeLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/cinema --output-dir ./core/lib/src/localizations/generated --template-arb-file cinema_en.arb --output-localization-file cinema_localizations.dart --output-class CinemaLocalizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/sports --output-dir ./core/lib/src/localizations/generated --template-arb-file sports_en.arb --output-localization-file sports_localizations.dart --output-class SportsLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/timeline --output-dir ./core/lib/src/localizations/generated --template-arb-file timeline_en.arb --output-localization-file timeline_localizations.dart --output-class TimelineLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/roomfinder --output-dir ./core/lib/src/localizations/generated --template-arb-file roomfinder_en.arb --output-localization-file roomfinder_localizations.dart --output-class RoomfinderLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/libraries --output-dir ./core/lib/src/localizations/generated --template-arb-file libraries_en.arb --output-localization-file libraries_localizations.dart --output-class LibrariesLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/benefits --output-dir ./core/lib/src/localizations/generated --template-arb-file benefits_en.arb --output-localization-file benefits_localizations.dart --output-class BenefitsLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/launch_flow --output-dir ./core/lib/src/localizations/generated --template-arb-file launch_flow_en.arb --output-localization-file launch_flow_localizations.dart --output-class LaunchFlowLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/studies --output-dir ./core/lib/src/localizations/generated --template-arb-file studies_en.arb --output-localization-file studies_localizations.dart --output-class StudiesLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/lectures --output-dir ./core/lib/src/localizations/generated --template-arb-file lectures_en.arb --output-localization-file lectures_localizations.dart --output-class LecturesLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/people --output-dir ./core/lib/src/localizations/generated --template-arb-file people_en.arb --output-localization-file people_localizations.dart --output-class PeopleLocatizations --no-synthetic-package
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/developerdex --output-dir ./core/lib/src/localizations/generated --template-arb-file developerdex_en.arb --output-localization-file developerdex_localizations.dart --output-class DeveloperdexLocatizations --no-synthetic-package

run_generator: check_fvm_info
	$(FVM_DART) run build_runner build --delete-conflicting-outputs

generate_splash_screen: check_fvm_info
	$(FVM_DART) run flutter_native_splash:create

update_pods: check_fvm_info
	cd ios && pod repo update && pod install && cd ..

love: check_fvm_info
	$(FVM_FLUTTER) pub get
	$(MAKE) localizations
	$(MAKE) update_pods

activate_mason: 
# Ensure mason is activated globally, we do not use fvm for mason
	dart pub global activate mason_cli
	mason --version
	mason add feature_module --path bricks/feature_module
	mason add shared_api --path bricks/shared_api
	mason add core_routes --path bricks/core_routes
