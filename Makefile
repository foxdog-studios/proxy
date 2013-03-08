.DEFAULT_GOAL := build

BUILD_DIR := build
BUILD_LIB_DIR := $(BUILD_DIR)/lib
COFFEE := node_modules/coffee-script/bin/coffee
PROXY_JS := $(BUILD_LIB_DIR)/proxy.js
PROXY_COFFEE := lib/proxy.coffee

build: $(PROXY_JS)
.PHONY: build

clean:
	rm -fr $(BUILD_DIR)
.PHONY: clean

$(PROXY_JS): $(PROXY_COFFEE)
	mkdir -p $(BUILD_LIB_DIR)
	$(COFFEE) -o $(BUILD_LIB_DIR) $(PROXY_COFFEE)


