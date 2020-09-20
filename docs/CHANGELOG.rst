.. role:: raw=html=m2r(raw)
   :format: html


Changelog
---------

`1.1.0 <https://github.com/saltstack-formulas/nut-formula/compare/v1.0.0...v1.1.0>`_ (2020-09-20)
-----------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** use ``saltimages`` Docker Hub where available [skip ci] (\ `4e93dbd <https://github.com/saltstack-formulas/nut-formula/commit/4e93dbdf293be52c0320fe4eb5d9d35acf4f0433>`_\ )

Features
^^^^^^^^


* **services:** don't manage them in mode=none (\ `e094946 <https://github.com/saltstack-formulas/nut-formula/commit/e094946e42c05f9f750289d9a2ea487b156e0fe5>`_\ )

Styles
^^^^^^


* **libtofs.jinja:** use Black-inspired Jinja formatting [skip ci] (\ `15d4810 <https://github.com/saltstack-formulas/nut-formula/commit/15d48103fc8ba515f9cf49a042acbf9b08aeb89b>`_\ )

`1.0.0 <https://github.com/saltstack-formulas/nut-formula/compare/v0.2.0...v1.0.0>`_ (2020-06-01)
-----------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **amazon:** remove improvable distro for UPS management (\ `424467b <https://github.com/saltstack-formulas/nut-formula/commit/424467befc3332770313200375b7c7ebb91867bb>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **states+config:** to conform to “template-formula” standard (\ `ae33686 <https://github.com/saltstack-formulas/nut-formula/commit/ae33686a90ce44c9f35a06a670a3370cfbf02680>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* **states+config:** the templates are now under "nut/files/default".
* **states+config:** "pkg" and "extra_pkgs" are now merged under a "pkgs" list.
* **states+config:** config file names are now under "<server|client>.\ :raw-html-m2r:`<component>`.config.file"
