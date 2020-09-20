.. _readme:

nut-formula
===========

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/nut-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/nut-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula to install and configure `Network UPS Tools <http://networkupstools.org/>`_.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please pay attention to the ``pillar.example`` file and/or `Special notes`_ section.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Usage
-----

NUT has *server* and *client* applications and packages are usually separated in those two categories, so the states reflect this situation:

* <server> states are required to manage the packages that directly deal with the UPS (driver, nut-server, etc.)
* <client> states are required to manage the packages that communicate with the *nut-server* (upsmon, upssched, etc.)

Special notes
-------------

Following *NUT*'s configuration logic, when ``nut.mode: 'none'``, the ``.running`` states will do nothing and skip the services management.
Therefore, they'll be left as the OS packages set them.

Available states
----------------

For each of the components, there are *meta-states* named after the component that will include other states in the component subdir
that perform the actual work.

For example, using *server* will include, in order:

* server.package.install
* server.config.mode
* server.config.ups
* server.config.upsd
* server.config.users
* server.service.running

You can use individual states, like

* client.package.install
* client.config.upsmon

.. contents::
   :local:

``nut``
^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the nut server and client packages,
manages the nut configuration files and then
starts the associated nut services.

``nut.<component>.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install the nut <component> packages only.

``nut.<component>.config``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will configure the nut <component> service/s and has a dependency on ``nut.<component>.package.install``
via include list.

``nut.<component>.service``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will start the nut <component> service/s and has a dependency on ``nut.<component>.config``
via include list.

``nut.clean``
^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``nut`` meta-state in reverse order, i.e.
stops the service, removes the configuration file and then uninstalls the packages.

``nut.<component>.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will stop the nut <component> service/s and disables them at boot time.

``nut.<component>.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the nut <component> service and has a
dependency on ``nut.<component>.service.clean`` via include list.

``nut.<component>.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the nut <component> package/s and has a depency on
``nut.<component>.config.clean`` via include list.

``nut.<component>``
^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state installs, configures and manage a <component> and starts the associated services.

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``nut`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

