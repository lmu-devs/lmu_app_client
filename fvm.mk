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
FVM_PREFIX := $(if $(USE_FVM),fvm ,)
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