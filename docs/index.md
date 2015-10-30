---
layout: page
title: Documentation
group: navigation
tagline: ~
---
{% include JB/setup %}

<dl>
  <dt><a href="cpran/">CPrAN</a></dt>
  <dd>What is CPrAN? An explanation of the protocol</dd>
  <dt>Commands</dt>
  <dd>What are CPrAN commands? What commands are available? How do I use them?</dd>
  <dd><dl>
{% capture plugins %}
  {% for node in site.pages %}
    {% if node.group == 'command' %}
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
    <dt><a href="{{ my_url | remove: "index.html" }}">{{ my_title }}</a></dt>
    <dd>{{ my_description }}</dd>
  {% endif %}
{% endfor %}
{% assign pages_list = nil %}
{% assign group = nil %}
  </dl>
  </dd>
  <dt><a href="plugins/">Plugins</a></dt>
  <dd>What is a CPrAN plugin? How is it different from a Praat plugin? How do I make a new plugin?</dd>
  <dd><dl>
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
    <dt><a href="{{ BASE_PATH }}/docs/plugins/{{ my_title }}">{{ my_title }}</a></dt>
    <dd>{{ my_description }}</dd>
  {% endif %}
{% endfor %}
{% assign pages_list = nil %}
{% assign group = nil %}
  </dl>
  </dd>
  <dt><a href="clients/">Clients</a></dt>
  <dd>What is a CPrAN client? How do I make one?</dd>
  <dd><dl>
    <dt><a href="clients/cpran">cpran</a></dt>
    <dd>The official client, written in Perl</dd>
  </dl></dd>
</dl>

