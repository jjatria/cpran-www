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
      *{{ node.title }}#{{ node.url }}#{{ node.project }}#{{ node.description.short }}#{{ node.pid }}
    {% endif %}
  {% endfor %}
{% endcapture %}
{% assign sorted_plugins = plugins | split:'*' | sort %}
{% for plugin in sorted_plugins %}
  {% assign items = plugin | split:'#' %}
  {% assign my_title       = items[0] %}
  {% assign my_url         = items[1] %}
  {% assign my_project     = items[2] %}
  {% assign my_description = items[3] %}
  {% assign my_pid         = items[4] %}
  {% if my_pid != NULL %}
    <tr>
    <td><a href="{{ BASE_PATH }}{{ my_url | remove: "/index.html" }}">{{ my_title }}</a></td>
    <td>{{ my_description }}</td>
    <td><a href="{{ my_project }}"><img alt="{{ my_title }} build badge" src="https://ci.gitlab.com/projects/{{ my_pid | strip | strip_newlines }}/status.png?ref=master" /></a>
    <td><a href="{{ BASE_PATH }}/docs/plugins/{{ my_title }}">View</a></td>
    </tr>
  {% endif %}
{% endfor %}
{% assign pages_list = nil %}
{% assign group = nil %}
</tbody>
</table>
