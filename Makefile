NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
NAMESPACE=minecraft-server
DATAFOLDER=minecraft-data
HOME ?= $(shell echo $$HOME)

default: help

help: ## Show this help
	@IFS=$$'\n' ; \
    help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
    printf "%-30s %s\n" "target" "help" ; \
    printf "%-30s %s\n" "------" "----" ; \
    for help_line in $${help_lines[@]}; do \
        IFS=$$':' ; \
        help_split=($$help_line) ; \
        help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
        help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
        printf '\033[36m'; \
        printf "%-30s %s" $$help_command ; \
        printf '\033[0m'; \
        printf "%s\n" $$help_info; \
    done

start: ## Start server
	@kubectl create namespace $(NAMESPACE)
	@mkdir -p $(HOME)/$(DATAFOLDER)
	@envsubst < kubernetes.yml | kubectl -n $(NAMESPACE) apply -f -
	@echo "$(OK_COLOR)==> Running on port 19132 $(NO_COLOR)"

stop: ## Stop server
	@kubectl delete namespace $(NAMESPACE) --ignore-not-found=true

restart: ## Restart server
	@make stop
	@make start

logs: ## See server logs
	@kubectl -n minecraft-server logs statefulset/bds -f

bash: ## Exec bash in the server pod
	@kubectl exec -it bds-0 -n minecraft-server -- bash

config: ## Configure server once running
	@kubectl exec -it bds-0 -n minecraft-server -- send-command op rtrzebinski
	@kubectl exec -it bds-0 -n minecraft-server -- send-command gamerule dofiretick false
	@kubectl exec -it bds-0 -n minecraft-server -- send-command gamerule showCoordinates true
	@kubectl exec -it bds-0 -n minecraft-server -- send-command gamerule pvp false
	@kubectl exec -it bds-0 -n minecraft-server -- send-command gamerule drowningdamage false
	@kubectl exec -it bds-0 -n minecraft-server -- send-command gamerule falldamage false
	@kubectl exec -it bds-0 -n minecraft-server -- send-command gamerule keepinventory true
