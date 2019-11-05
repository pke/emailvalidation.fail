---
title: Why this site
layout: default
---

These are all valid email addresses:

{% for email in site.data.valid_emails %}
  
  `{{email}}`
{% endfor %}
<br>

{%- assign randomFails = site.data.fails | sample: 3 -%}

{%- assign resultFails = "" | split: ',' -%}

{%- for fail in randomFails -%}
  {%- assign name = fail.name | strip -%}
  {%- assign desc = fail.desc | strip | split: ' ' | first -%}
  {%- if desc contains "http" -%}
    {%- assign resultFails = resultFails | push: desc -%}
  {%- else -%}
    {%- assign resultFails = resultFails | push: name -%}
  {%- endif -%}
{%- endfor -%}

Yet some sites specify them as invalid. That's because [validating emails is hard](https://regex101.com/r/xbG42N/1/tests).

But one does not have to use a complex check to allow a very common email address format:

> `name+extension@gmail.com`
