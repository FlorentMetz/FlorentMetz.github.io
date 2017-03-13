---
layout: default
---

{% capture know_more %}
  {% if locale == 'fr' %}Veux-tu en savoir plus
  {% else %}Do you want to know more
  {% endif %}?
{% endcapture %}

<div id="main">
  {% assign lengthCateogries = page.categories | size %}
  <article>
    <header>
      <h1 class="post-title">{{ page.title }}</h1>
      <p class="post-meta">Written around {{ page.date | date: "%b %-d, %Y" }}{% if lengthCateogries != 0 %} - tags: {{ page.categories | array_to_sentence_string }}{% endif %}</p>
    </header>

    <section>
      {% if page.excerpt %}{{ page.excerpt | markdownify }}{% endif %}
      {{ page.content }}
    </section>

    <section>{% include comments.html %}</section>

    <footer>
      <div class="row">
      {% if page.previous %}
        <article class="{% cycle '6u', '6u$' %} 12u(small) excerpt">
          <header>
            <h2><a href="{{ page.previous.url }}">{{ page.previous.title }}</a></h2>
          </header>
          <section>{{ page.previous.excerpt | markdownify }}</section>
          <footer>
            <ul class="actions">
              <li><a href="{{ page.previous.url }}" class="button">{{ know_more }}</a></li>
            </ul>
          </footer>
        </article>
      {% endif %}

      {% if page.next %}
        <article class="{% cycle '6u', '6u$' %} 12u(small) excerpt f-right">
          <header>
            <h2><a href="{{ page.next.url }}">{{ page.next.title }}</a></h2>
          </header>
          <section>{{ page.next.excerpt | markdownify }}</section>
          <footer>
            <ul class="actions">
              <li><a href="{{ page.next.url }}" class="button">{{ know_more }}</a></li>
            </ul>
          </footer>
        </article>
      {% endif %}
      </div>
    </footer>
  </article>
</div>
