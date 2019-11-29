---
title: Frequently Asked Questions (FAQ)
keywords: support faq questions
tags: [support]
toc: false
sidebar: overview_sidebar
permalink: support_faq.html
summary: "Frequently Asked Questions (FAQ)."
---

{% comment %}
https://idratherbewriting.com/documentation-theme-jekyll/mydoc_faq_layout.html
{% endcomment %}

{% assign last_idx = site.data.faqs.size | minus: 1 %}

<div class="panel-group" id="faqs">
{% for idx in (0..last_idx) %}
<div class="panel panel-default">
<div class="panel-heading">
<div class="panel-title">
<a class="noCrossRef accordion-toggle" data-toggle="collapse" data-parent="#faqs" href="#faq-{{ idx }}" markdown="1">
{{ site.data.faqs[idx].question }}
</a>
</div>
</div>
<div id="faq-{{ idx }}" class="panel-collapse collapse noCrossRef">
<div class="panel-body" markdown="1">
{{ site.data.faqs[idx].answer }}
</div>
</div>
</div>
{% endfor %}
</div>
