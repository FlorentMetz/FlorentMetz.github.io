---
layout: default
title: Blog
permalink: /dev
---

<div id="main">
  <section>
    {% for post in site.posts limit:1 %}
      <header>
        <h1>{{ post.title }}</h1>
        <p class="post-meta">{{ post.date | date: "%b %-d, %Y" }}{% if post.author %} • {{ post.author }}{% endif %}{% if page.meta %} • {{ page.meta }}{% endif %}</p>
      </header>
      <section>
        {{ post.excerpt | markdownify }}
        {{ post.content }}
      </section>
    {% endfor %}
  </section>

  <section>
    <div class="row">
      {% for post in site.posts offset:1 %}
        <article class="{% cycle '6u', '6u$' %} 12u(small)">
          <header>
            <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
          </header>
          <section>{{ post.excerpt | markdownify }}</section>
          <footer>
            <ul class="actions">
              <li><a href="{{ post.url }}" class="button">Do you want to know more?</a></li>
            </ul>
          </footer>
        </article>
      {% endfor %}
    </div>
  </section>
</div>
