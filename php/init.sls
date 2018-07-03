{% from "php/map.jinja" import php with context %}

{% set use_ppa        = salt['pillar.get']('php:use_ppa', none) %}

{% if grains['os_family']=="Debian" %}
{% if use_ppa is not none %}

{% set ppa_name        = salt['pillar.get']('php:ppa_name', 'ondrej/php') %}

php54:
    pkgrepo.managed:
        - ppa: {{ ppa_name }}
        - keyid: E5267A6C
        - keyserver: keyserver.ubuntu.com
    cmd.run:
        - name: 'apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C'
        - unless: 'apt-key list | grep Launchpad'
    pkg.latest:
        - name: php5.6
        - refresh: True
        - force_yes: True
{% endif %}
{% endif %}

php:
  pkg:
    - installed
    - name: {{ php.php_pkg }}
