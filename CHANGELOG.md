# Changelog

## [Unreleased]
### Added
- TODO

## [0.4.0] - 2020-11-08
### Added
- Input parameter `working_languages` (syntactic sugar for `--agendum-linguam`)
- Input parameter `non_working_languages` (syntactic sugar for `--non-agendum-linguam`)
- Input parameter `auxiliary_languages` (syntactic sugar for `--auxilium-linguam`)
- Input parameter `source_language` (syntactic sugar for `--fontem-linguam`)
- Input parameter `target_language` (syntactic sugar for `--objectivum-linguam`)
- Input parameter `export_ad_hoc_template` (syntactic sugar for `--objectivum-formulam`)
- Input parameter `export_data_exchange_standard` (syntactic sugar for `--objectivum-<VALUE>`)
- Input parameter `dump_abstract_syntax_tree` (syntactic sugar for `--expertum-HXLTM-ASA`)

## [0.3.0] - 2020-11-07

### Added
- `hxltm-action-example`, dedicated example repository as test case for this action

### Changed
- Optimization: Dockerfile `FROM python:3.9-bullseye` -> `FROM python:3.9-alpine`

### Fixed
- hxltmcli v0.8.8 --objectivum-formulam allow save result to file (was working
  for only for stdout, incompatible with hxltm-action)

## [0.2.0] - 2020-11-06
### Added
- First pre-release published on GitHub Marketplace

## [0.1.0] - 2020-11-04
### Added
- _Fiat lux!_