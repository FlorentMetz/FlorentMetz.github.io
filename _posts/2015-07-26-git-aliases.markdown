---
layout: post
title:  "Get some git aliases"
date:   2015-07-26 11:37:00
excerpt: Here is my `~/.gitconfig` for aliases - which could probably be improved.
categories: git
---

{% highlight bash %}
[alias]
    d = diff -b
    br = branch -av
    st = status
    ls = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
    pf = !git pull && git fetch --all -p
    sb = submodule update --init --recursive
{% endhighlight %}

### Explanation

- `git d` will show you the differences between files, without spaces.
- `git br` will show you local and remote branches with last commit.
- `git st` will show your current working state.
- `git ls` will show a pretty log.
- `git lg` will show a prettier log (including the date of commit).
- `git pf` will pull from current branch and fetch everything, pruning.
- `git sb` will update your submodules.

Dont forget you can also set the [color] in your terminal!

[color]: https://git-scm.com/book/tr/v2/Customizing-Git-Git-Configuration#Colors-in-Git
