# Detect OS (Windows or Unix-based) for shell command compatibility
ifeq ($(OS),Windows_NT)
    SHELL := cmd.exe
    FVM_EXISTS := $(shell if exist .fvm (echo 1))
else
    SHELL := /bin/sh
    FVM_EXISTS := $(shell test -d .fvm && echo 1)
endif

# If .fvm directory exists, USE_FVM will be '1'.
# Can be manually overridden by passing USE_FVM=0 or USE_FVM=1 to make.
USE_FVM ?= $(FVM_EXISTS)

# If USE_FVM is '1', commands will be prefixed with 'fvm'.
# Otherwise, no prefix is used (default Flutter/Dart from PATH).
FVM_PREFIX := $(if $(USE_FVM),fvm ,) # Note the space after 'fvm'
FVM_FLUTTER := $(FVM_PREFIX)flutter
FVM_DART := $(FVM_PREFIX)dart

export PRINTED_FVM_INFO ?=

.PHONY: check_fvm_info
check_fvm_info:
ifeq ($(PRINTED_FVM_INFO),)
ifeq ($(USE_FVM),1)
	@echo "All commands in this Makefile will be executed using the Flutter SDK defined by FVM (e.g., 'fvm flutter ...')."
	@echo "This is because a '.fvm' directory was detected in the project root."
	@echo "You can override this behavior by running 'make USE_FVM=0 <target>'."
else
	@echo "All commands in this Makefile will be executed using the default Flutter SDK (e.g., 'flutter ...')."
	@echo "This is because no '.fvm' directory was detected in the project root, or USE_FVM was explicitly set to 0."
	@echo "If you intend to use FVM, ensure '.fvm' is present or run 'make USE_FVM=1 <target>'."
endif
	$(eval PRINTED_FVM_INFO := true)
	@echo "PRINTED_FVM_INFO is set to true to avoid printing this message again. ${PRINTED_FVM_INFO}"
endif

# --- Main Targets ---
.PHONY: localizations run_generator generate_splash_screen update_pods love

localizations: check_fvm_info
	$(FVM_FLUTTER) gen-l10n --arb-dir ./l10n/app --output-dir ./core/lib/src/localizations/generated --template-arb-file app_en.arb --output-localization-file app_localizations.dart --output-class AppLocalizations --no-synthetic-package
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