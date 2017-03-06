---
layout: post
title:  "How to log your deployments with codebase"
date:   2015-08-01 15:30:00
categories: capifony codebase
excerpt: I use [codebase](https://www.codebasehq.com/) at work for hosting our projects using git. I discovered recently that I could also log every deployment I make with capifony on either our staging or production environment (or both).
---

It is quite straightforward to setup, and codebase explain every step to follow in their "Show Setup Instructions":

### Install codebase locally

{% highlight bash %}
sudo gem install codebase4
{% endhighlight %}

### Link your codebase account

Go to your "Deploys" page and find your token, then run

{% highlight bash %}
cb token domain.codebasehq.com [token]

# check if it worked:
cb test domain.codebasehq.com
{% endhighlight %}

### Log your deployment

{% highlight bash %}
cb deploy (prev_hash) (current_hash) -s (domains) -e (environment) -b (branch) -h domain.codebasehq.com -r (project) --protocol https
{% endhighlight %}

- `prev_hash` is the commit hash the project was at before the deployment.
- `current_has` is the commit hash you are deploying.
- `domains` is a list of domains you are deploying to. Can be a comma list (www.domain.com,www.domain.co.uk,....).
- `branch` is the branch you are deploying (usually `master` but hey - you could be deploying `staging` on a training environment).
- `project` is your codebase permalink project (visible in the URL of your codebase project).

### Automatically deploy with Capifony

I previously showed you how to use [capifony] and deploy your projects, it is now time to use capifony to log your deployment.

Add a custom task to your `app/config/deploy.rb` as follow:

{% highlight bash %}
namespace :custom do
    namespace :log do
        task :codebase do
            capifony_pretty_print "--> Logging deployment on codebase"
            run_locally "cb deploy #{previous_revision} #{current_revision} -s #{application} -e #{stage} -b #{branch} -h domain.codebasehq.com -r project --protocol https"
            capifony_puts_ok
        end
    end
end

after "deploy", "custom:log:codebase"
{% endhighlight %}

And now, after each `cap:deploy`, `custom:log:codebase` will be triggered and log the deployment on your codebase!

If everything goes well, you should see the list of your deployments in the "Deployments" tab of your projects:

{:.image.fit}
![a few deployments logged](/images/posts/deployments-on-codebase.png)
_a few deployments logged_

P.S: [Codebase] offers a free plan which gives you one project, 100MB disk space and 2 users.

[codebase]: https://www.codebasehq.com/
[capifony]: http://florentmetz.github.io/symfony/capifony/2015/07/29/Deploying-symfony-project-with-capifony.html
