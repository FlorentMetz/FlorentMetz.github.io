---
layout: default
---

<div id="main">
  <article>
    <header>
      <h1 class="post-title">{{ page.title }}</h1>
      <p class="post-meta">Written around {{ page.date | date: "%b %-d, %Y" }}{% if page.categories != '' %} • tags: {{ page.categories | array_to_sentence_string }}{% endif %}</p>
    </header>

    <section>
      {% if page.excerpt %}{{ page.excerpt | markdownify }}{% endif %}
      {{ page.content }}
    </section>

    <section>
      <div id="disqus_thread"></div>
      <script type="text/javascript">
        /* * * CONFIGURATION VARIABLES * * */
        var disqus_shortname = 'florentmetzdevblog';

        /* * * DON'T EDIT BELOW THIS LINE * * */
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
      </script>
      <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
    </section>

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
              <li><a href="{{ page.previous.url }}" class="button">Veux-tu en savoir plus?</a></li>
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
              <li><a href="{{ page.next.url }}" class="button">Veux-tu en savoir plus?</a></li>
            </ul>
          </footer>
        </article>
      {% endif %}
      </div>
    </footer>
  </article>
</div>
