===========
nut-formula
===========

A saltstack formula to install and configure `Network UPS Tools <http://networkupstools.org/>`_.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Supported distros
=================

Should work OK on

* Debian (Jessie / Stretch)
* Ubuntu (14.04 / 16.04)
* CentOS 7

Available states
================

.. contents::
    :local:

``nut``
-------

Installs the nut server and client packages, configures them and starts the associated nut services.

This state includes the following ones.

``nut.server``
-------

Installs the nut server server packages, configures it and starts the associated nut services.

``nut.client``
-------

Installs the nut client package/s, configures them and starts the associated nut services (upsmon).

Testing
=======

Testing is done with the ``kitchen-salt``.

``kitchen converge``
--------------------

Runs the ``nut`` main state.

``kitchen test``
----------------

Builds and runs tests from scratch.

``kitchen login``
-----------------

Gives you ssh to the vagrant machine for manual testing.

.. vim: fenc=utf-8 spell spl=en cc=100 tw=99 fo=want sts=2 sw=2 et

