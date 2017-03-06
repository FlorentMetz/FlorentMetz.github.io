---
layout: default
---

<div id="main">
  <article>
    <header><h1 class="post-title">{{ page.title }}</h1></header>

    <section>{{ content }}</section>

    <section>{% include comments.html %}</section>
  </article>
</div>
