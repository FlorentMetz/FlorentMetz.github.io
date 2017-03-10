---
layout: post
locale: en
title:  "Minimise your css files with Jekyll and SASS"
date:   2017-03-10 16:00:00
categories: jekyll sass
excerpt: "A quick tip about making your jekyll blog faster to load and render!"
---

I had some simple .css stylesheets I wanted to minimise and I started looking at js tools to minimise them.
Turns out, I can tell Jeyll to compress them with some sass configuration!

# Update your Stylesheets

- Rename your .css files into .scss
- Add 2 lines of triples dashes to the beginning of each files.

For instance, if you have a `main.css`
{% highlight css linenos %}
.highlight code {
  background-color: #49483e;
  border-radius: 0;
  border: 0;
}
{% endhighlight %}

Rename to `main.scss`

{% highlight css linenos %}
---
---

.highlight code {
  background-color: #49483e;
  border-radius: 0;
  border: 0;
}
{% endhighlight %}

# Update your configuration

In your `_config.yml`, add the following:

{% highlight yaml %}
sass:
  style: compressed
{% endhighlight %}

That's all! Jekyll should minimise the .scss files into .css files.

[More documentation on Jekyll's website](https://jekyllrb.com/docs/assets/)
