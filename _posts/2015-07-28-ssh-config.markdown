---
layout: post
title:  "Manage your hostnames with SSH Config"
date:   2015-07-28 21:20:00
categories: linux
excerpt: Logging into a remote server from your terminal could be a pain if you use the ssh command with the options of your private key, username and stuff. Fortunately, you can create a config file for your hostnames.
---

Let's say that I want to log on a remote server called dummy.com with the username flotz and a private key found in ~/.ssh/private.key.
The SSH command would be:
{% highlight bash %}
ssh -l flotz -i ~/.ssh/private.key dummy.com
# Or even
ssh -i ~/.ssh/private.key flotz@dummy.com
{% endhighlight %}

Well, I will make my life easier by creating a config file for that hostname:
{% highlight bash %}
vi ~/.ssh/config

Host dummy
    Hostname dummy.com
    IdentityFile ~/.ssh/private.key
    User flotz
{% endhighlight %}

And now I can remotely connect by simply typing `ssh dummy`.

You might want to add more options like the Port or maybe the ForwardAgent if you work with git.

{% highlight bash %}
# in ~/.ssh/config
Host dummy
    Hostname dummy.com
    IdentityFile ~/.ssh/private.key
    User flotz
    Port 1234
    ForwardAgent yes
{% endhighlight %}

**Pro-tip**: you can add more than one Host as long as you separate them with whitespaces:

{% highlight bash %}
# in ~/.ssh/config
Host dummy dummy2
    Hostname dummy.com
    IdentityFile ~/.ssh/private.key
    User flotz
{% endhighlight %}
