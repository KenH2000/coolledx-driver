
.PHONY: help setup install test unit check lint full-commit-ready

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  setup      to setup project"
	@echo "  install    to install dependencies"
	@echo "  test       to run all tests"
	@echo "  unit       to run unit tests"
	@echo "  check      to run pre-commit checks"
	@echo "  lint       to run flake8"
	@echo "  commit-ready      to run pre-commit checks, unit
	@echo "  full-commit-ready to update all dev tools and run pre-commit checks"

setup:
	@poetry init
	@pre-commit install

system-requirements-install:
	@installer-install rhysd/actionlint

install:
	@poetry install

pre-commit-autoupdate:
	@poetry run pre-commit autoupdate

unit:
	@poetry run coverage run -m pytest -s -v
	@poetry run coverage report -m
	@poetry run coverage html

check:
	@poetry run pre-commit run --all-files

check-github-actions:
	@poetry run pre-commit run --hook-stage manual actionlint

commit-ready: check unit

full-commit-ready: pre-commit-autoupdate commit-ready

lint:
	@poetry run flake8

sphinx-start:
	@poetry run sphinx-quickstart docs

sphinx-build:
	@poetry run sphinx-build -b html docs docs/_build

publish-to-pypi:
	@poetry publish --build

build:
	@poetry build
