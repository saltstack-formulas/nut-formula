# Changelog

# [1.0.0](https://github.com/saltstack-formulas/nut-formula/compare/v0.2.0...v1.0.0) (2020-06-01)


### Bug Fixes

* **amazon:** remove improvable distro for UPS management ([424467b](https://github.com/saltstack-formulas/nut-formula/commit/424467befc3332770313200375b7c7ebb91867bb))


### Code Refactoring

* **states+config:** to conform to “template-formula” standard ([ae33686](https://github.com/saltstack-formulas/nut-formula/commit/ae33686a90ce44c9f35a06a670a3370cfbf02680))


### BREAKING CHANGES

* **states+config:** the templates are now under "nut/files/default".
* **states+config:** "pkg" and "extra_pkgs" are now merged under a "pkgs" list.
* **states+config:** config file names are now under "<server|client>.<component>.config.file"
