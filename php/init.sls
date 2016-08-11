{% from "php/map.jinja" import php with context %}

{% set use_ppa        = salt['pillar.get']('php:use_ppa', none) %}

{% if grains['os_family']=="Debian" %}
{% if use_ppa is not none %}

{% set ppa_name        = salt['pillar.get']('php:ppa_name', 'ondrej/php') %}

php54:
    pkgrepo.managed:
        - ppa: {{ ppa_name }}
    pkg.latest:
        - name: php5
        - refresh: True
{% endif %}
{% endif %}

php:
  pkg:
    - installed
    - name: {{ php.php_pkg }}
