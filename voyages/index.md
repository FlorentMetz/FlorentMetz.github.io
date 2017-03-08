---
layout: default
title: Mes voyages d'içi et ailleurs
permalink: /voyages
---

<div id="main">
  <section>
    {% for travel in site.travels reversed limit:1 %}
      <header>
        <h1>{{ travel.title }}</h1>
        <p class="post-meta">{{ travel.created_at | date: "%b %-d, %Y" }}</p>
      </header>
      <section>
        {% if travel.excerpt %}{{ travel.excerpt | markdownify }}{% endif %}
        {{ travel.content }}
      </section>
    {% endfor %}
  </section>

  <section>
    <div class="row">
      {% for travel in site.travels reversed offset:1 %}
        <article class="{% cycle '6u', '6u$' %} 12u(small)">
          <header>
            <h2><a href="{{ travel.url }}">{{ travel.title }}</a></h2>
          </header>
          {% if travel.excerpt %}
          <section>{{ travel.excerpt | markdownify }}</section>
          <footer>
            <ul class="actions">
              <li><a href="{{ travel.url }}" class="button">Veux-tu en savoir plus?</a></li>
            </ul>
          </footer>
          {% endif %}
        </article>
      {% endfor %}
    </div>
  </section>
</div>
