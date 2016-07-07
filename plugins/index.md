---
layout: page
title: Plugins
group: navigation
tagline: ~
---
{% include JB/setup %}

<table>
<thead>
<tr><th>Name</th><th>Description</th><th>Status</th><th>Help</th></tr>
</thead>
<tbody>
{% capture plugins %}
  {% for node in site.pages %}
    {% if node.group == 'plugin' %}
      *{{ node.title }}#{{ node.url }}#{{ node.project }}#{{ node.description.short }}
    {% endif %}
  {% endfor %}
{% endcapture %}
{% assign sorted_plugins = plugins | split:'*' | sort %}
{% for plugin in sorted_plugins %}
  {% assign items = plugin | split:'#' %}
  {% assign my_title       = items[0] | lstrip %}
  {% assign my_url         = items[1] %}
  {% assign my_project     = items[2] %}
  {% assign my_description = items[3] %}
  {% unless my_title == empty %}
    <tr>
    <td><a href="{{ BASE_PATH }}{{ my_url | remove: "/index.html" }}">{{ my_title }}</a></td>
    <td>{{ my_description }}</td>
    <td><a href="{{ my_project }}"><img alt="{{ my_title }} status" src="https://gitlab.com/cpran/plugin_{{ my_title }}/badges/master/build.svg" /></a></td>
    <td><a href="{{ BASE_PATH }}/docs/plugins/{{ my_title }}">View</a></td>
    </tr>
  {% endunless %}
{% endfor %}
{% assign pages_list = nil %}
{% assign group = nil %}
</tbody>
</table>
