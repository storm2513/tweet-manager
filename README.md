# Tweet Manager #

## What is it? ##

It's a Ruby on Rails application that allows you to post tweets to Twitter.com. It uses `omniauth` gem for Oauth authentication and `twitter` gem for posting via Twitter API.

## How to install? ##

Firstly, you should clone this repository.
Then you have to install gems:

```bash
$ cd tweet-manager
$ bundle install
```

### Database: ###

This Rails application uses MySQL database. So you should run MySQL server.
Then you should provide your MySQL credentials to `/config/database.yml` file.
When you're done, you can create databases for Rails development and test environments and apply pending migrations:

```bash
$ rails db:setup
```

### Twitter API keys: ###

To make Oauth authentication and tweets posting work you should provide Twitter API keys to this Rails application.
You can get them by creating an app on `https://developer.twitter.com`.
This app should have read and write permissions and have `http://127.0.0.1:3000/auth/twitter/callback` as callback url.
Then you are able to get Consumer API keys (key and secret).
Place them in `.env_sample` file and rename it to just `.env`:

```bash
$ mv .env_sample .env
```

### Starting Rails application: ###

Now you are able to start Rails server:

```bash
$ rails server
```

Then go to the "http://127.0.0.1:3000" and enjoy this application :)
