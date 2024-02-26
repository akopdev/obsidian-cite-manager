.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
.PHONY: all 			 			 # All targets are accessible for user
.DEFAULT: help 			 		 # Running Make will run the help target

# -------------------------------------------------------------------------------------------------
# help: @ List available tasks on this project
# -------------------------------------------------------------------------------------------------
help:
	@grep -oE '^#.[a-zA-Z0-9]+:.*?@ .*$$' $(MAKEFILE_LIST) | tr -d '#' |\
	awk 'BEGIN {FS = ":.*?@ "}; {printf "  make%-10s%s\n", $$1, $$2}'
	
# -------------------------------------------------------------------------------------------------
# start: @ Run the development server
# -------------------------------------------------------------------------------------------------
start: 
	@npm run dev
	
# -------------------------------------------------------------------------------------------------
# build: @ Build the project
# -------------------------------------------------------------------------------------------------
build: 
	@npm run build

# -------------------------------------------------------------------------------------------------
#  release: @ Create a new release
#  -------------------------------------------------------------------------------------------------
release:
	$(eval VERSION := $(shell cat package.json | jq -r '.version'))
	@git tag $(VERSION)
	@git push origin --tags
	@echo "Release $(VERSION) successfully created!"
