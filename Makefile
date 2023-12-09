FORMATTER=stylua
LINTER=luacheck

.PHONY: lint format precommit

help: ## Print this message
	@echo "usage: make [target] ..."
	@echo ""
	@echo "Available targets:"
	@grep --no-filename "##" $(MAKEFILE_LIST) | \
		grep --invert-match $$'\t' | \
		sed -e "s/\(.*\):.*## \(.*\)/ - \1:  \t\2/"

lint: ## Lint project codebase
	$(LINTER) .

format: ## Format project codebase
	$(FORMATTER) .

precommit: lint format ## Prepare codebase for commiting changes to GitHub
