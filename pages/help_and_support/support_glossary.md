---
title: Glossary
keywords: abbreviations definitions glossaries terms
tags: [overview]
sidebar: overview_sidebar
permalink: support_glossary.html
summary: Glossary of terms used by this implementation guide.
toc: false
---

Glossary of common terms and abbreviations used throughout this documentation site.

{% assign glossary = site.data.glossary | sort_natural: "term" %}

<dl>
{% for entry in glossary %}
<dt id="{{ entry.term | slugify }}" markdown="0">{{ entry.term }}</dt>
<dd markdown="1">
{{ entry.definition }}
</dd>
{% endfor %}
</dl>

<script>
	$(function() {
        anchors.add('dt');
	});
</script>
