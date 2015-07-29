---
layout: post
title:  "Deploying a Symfony project with Capifony"
date:   2015-07-29 14:50:00
categories: symfony capifony
---

I have been working with Symfony2 for a while now and recently I have been looking at deploying symfony projects on remote servers (in my case, [AWS]) without having to SSH and manually run whatever commands the projects need to be run.

[Capifony] is what I am playing with at the moment.

### Installing Capifony

In order to run capifony, you will need to install ruby:

{% highlight bash %}
sudo apt-get install ruby

# Once ruby install (current stable version is 2.2.2) - Install capifony (current version 2.8.6)

sudo gem install capifony
{% endhighlight %}

Once you have ruby and capifony installed, go ahead and capifony your symfony project:
{% highlight bash %}
cd /var/www/awesome-project/
capifony .
{% endhighlight %}

The last command will create a `Capfile` at the root of your folder, and a `deploy.rb` in `app/config/`.

You shouldn't have to change anything in your Capfile. Most of the changes will be done in `app/config/deploy.rb`.

Capifony's website describes pretty well how to simply setup a deployment so I am just going to be lazy and dump my configuration, and explain what it does :)

I use capifony in a multistage environment (staging and production) which I keep in:

- `app/config/environments/production.rb`
- `app/config/environments/staging.rb`

The two files contains the differences between the two servers (two stages).

For instance: the hostname is different, the git branch I want to deploy is different (`development` on staging and `master` on production)

{% highlight ruby %}
# app/config/environments/production.rb

set :application,   'awesome-project'

server              'production-awesome', :app, :web, :primary => true
set :branch,        'master'
{% endhighlight %}

server `production-awesome` is the hostname I have setup in my [~/.ssh/config]

{% highlight ruby %}
# app/config/deploy.rb

set :stages,        %w(production staging)          # List here all your stages
set :default_stage, "staging"                       # The default stage to load
set :stage_dir,     "app/config/environments"       # Where to go find the stage settings files
require 'capistrano/ext/multistage'

set :user,          "my-user"       # User to use on the remote server
set :group,         "my-group"      # Group to use on the remote server

set :use_sudo,      true
set :scm,           :git
set :repository,    "git@wherever.com:dummy.git"    # Your git repository url
set(:deploy_to)     { "/var/www/#{application}" }   # Where to deploy your code to
set :rails_env,     'production'                    # rails environment should remain production

# deploy_via remote cache if you don’t want to clone the whole repository on every deploy
set :deploy_via,    :remote_cache

default_run_options[:pty] = true

# forward SSH key agent
set :ssh_options, {
    :forward_agent => true
}

set :app_path,          "app"
set :model_manager,     "doctrine"
set :interactive_mode,  false                           # The interactive mode is used with doctrine-migrations
set :shared_files,      ["app/config/parameters.yml"]   # My shared file between releases
set :shared_children,   [
        app_path + "/logs",
        app_path + "/cache",
        "vendor"
    ]

# composer settings
set :copy_vendors,          true
set :update_vendors,        true
set :composer_options,      "--no-dev --verbose --prefer-dist --optimize-autoloader --no-progress"

# assets settings
set :update_assets_version, false
set :assets_install,        true
set :assets_symlinks,       false
set :assets_relative,       false
set :dump_assetic_assets,   true

# permissions config
#set :writable_dirs,        ["app/cache", "app/logs"]
#set :webserver_user,       "www-data"
set :permission_method,     :chown
set :use_set_permissions,   true

set :keep_releases,         5

# Be more verbose by uncommenting the following line
# IMPORTANT = 0
# INFO      = 1
# DEBUG     = 2
# TRACE     = 3
# MAX_LEVEL = 3
logger.level = Logger::MAX_LEVEL

# Below are my custom commands
# custom:uname              to check the name of the remote servers
# custom:restart:apache     will gracefully restart apache2
# custom:flush:memcache     will flush memcache
namespace :custom do
    task :uname do
        run "uname -a"
    end
    namespace :restart do
        task :apache do
            capifony_pretty_print "--> Restarting Apache"
            try_sudo "service apache2 graceful"
            capifony_puts_ok
        end
    end
    namespace :flush do
        task :memcache do
            capifony_pretty_print "--> Flush memcache"
            run "sh -c 'echo 'flush_all' | nc localhost 11211'"
            capifony_puts_ok
        end
    end
end

# Below are my listeners:
before "symfony:cache:warmup", "symfony:doctrine:migrations:migrate"
before "symfony:cache:warmup", "symfony:cache:clear"
before "deploy:cleanup",       "custom:restart:apache"
after  "deploy",               "deploy:cleanup"                         # deploy:cleanup needs to be explicity run
{% endhighlight %}

With the above deploy settings, I can easily deploy on my staging remote server by running:

{% highlight bash %}
cap deploy
{% endhighlight %}

There is no need to specify the staging environment as it is the default (set by default_stage)

And on production:

{% highlight bash %}
cap production deploy
{% endhighlight %}

If you change the `logger.level` to `Logger::IMPORTANT`, the output of your capifony deployment will look a bit sexier than the other levels

![Capifony deployment in IMPORTANT level]({{ site.url }}/images/posts/capifony-deployment.png)

[AWS]: http://aws.amazon.com/
[Capifony]: http://capifony.org/
[~/.ssh/config]: http://florentmetz.github.io/linux/2015/07/28/ssh-config.html
