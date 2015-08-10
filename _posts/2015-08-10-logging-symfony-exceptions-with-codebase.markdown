---
layout: post
title:  "Logging your symfony exceptions with Codebase"
date:   2015-08-10 17:30:00
categories: symfony codebase
---

We previously saw how to log your deployments with [codebase], I am now going to show you how to log the exceptions from a symfony project (2.3+) in your codebase!

If you look at your codebase project, you'll see an "Exceptions" tab with some instructions about logging them. Find your codebase API key and create a listener in your symfony project to log the exceptions.

{% highlight yaml %}
# in app/config/parameters.yml.dist

codebase_api_key:   aaaaaa-bbbb-ccccc-ddddd-eeeeeee

# in app/config/config_prod.yml
services:
    kernel.listener.dummy_exception:
        class: App\MyBundle\Listener\ExceptionListener
        calls:
            - [setCodebaseKey, ["%codebase_api_key%"]]
        tags:
            - { name: kernel.event_listener, event: kernel.exception, method: onKernelException }
{% endhighlight %}

And now create a new listener in your `src/App/MyBundle/Listener/ExceptionListener.php`

{% highlight php %}
<?php

namespace App\MyBundle\Listener;

use Symfony\Component\HttpKernel\Event\GetResponseForExceptionEvent;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;

class ExceptionListener
{
    protected $codebaseKey  = null;

    /**
     * API Key provided by Codebase
     *
     * @param string
     *
     * @return ExceptionListener
     */
    public function setCodebaseKey($key)
    {
        $this->codebaseKey = $key;

        return $this;
    }

    public function onKernelException(GetResponseForExceptionEvent $event)
    {
        $client = new \Airbrake\Client(
            new \Airbrake\Configuration(
                $this->codebaseKey,
                array(
                    'host'      => 'exceptions.codebasehq.com',
                    'secure'    => true,
                    'resource'  => '/notifier_api/v2/notices',
                )
            )
        );
        $client->notifyOnException($event->getException());
    }
}
{% endhighlight %}

You will notice that in this listener, I am using Airbrake library. You can easily include it in your `composer.json`:

{% highlight json %}
"require": {
    ...
    "dbtlr/php-airbrake": "~1.1"
    ...
}
{% endhighlight %}

And from your terminal, run a `composer update` - which will update your vendors folder with Airbrake.

And now, once you have deployed this code on your server and anything goes wrong - codebase will notify you and log it in the "Exceptions" tab.

[![An exception logged by codebase](/images/posts/exception-in-codebase.png)](/images/posts/exception-in-codebase.png)

[codebase]: https://www.codebasehq.com/
