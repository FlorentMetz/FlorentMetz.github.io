---
layout: default
---

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<div id="main">
  <section>
    <div class="row">
        <article class="6u 12u(small)">
          <header>
            <h2><a href="/dev.html">Development Area (🇬🇧)</a></h2>
          </header>
          <section>
            <p>You'll find most of the technical stuff in this area.<br />
            Everything in this section will be written in English but since it is not my mother tongue, you might find mistakes or typos, sorry in advance 😂</p>
          </section>
        </article>

        <article class="6u$ 12u(small)">
          <header>
            <h2><a href="/voyages.html">Mes voyages (🇫🇷)</a></h2>
          </header>
          <section>
            <p>C'est là que tu retrouveras mes péripéties lors de mes différents voyages à travers le monde.</p>
          </section>
        </article>
    </div>
  </section>
  <section>
    <div class="row">
      <article>
        <header>
          <h2>Latest Instagram Posts</h2>
        </header>
      </article>
      <div id="instafeed" class="row"></div>
    </div>
  </section>
</div>
<script type="text/javascript">
  $(document).ready(function(){
    $.get('https://api.instagram.com/v1/users/self/media/recent/?count=12&access_token=2074401603.30e0ccb.1bab7b868b99480dbf33a04b9c4dbf14', function(apiReturn) {
      $.each(apiReturn.data, function(i, value) {
        $('#instafeed').append('<article><section><a target="_blank" href="'+value.link+'"><img src="'+value.images.thumbnail.url+'" title="'+value.caption.text+'" /></a></section></article>');
      });
    });
  });
</script>