# LawsOfRobotsTxt

1. A robot may not index staging servers
2. A robot must obey the sitemap
3. A robot may not injure SEO or, through inaction, cause SEO to come to harm.

## Installation

Add this line to your application's Gemfile:

    gem 'laws_of_robots_txt'

And then execute:

    $ bundle

Be sure to remove `public/robots.txt`, if it exists

## Usage

LawsOfRobotsTxt installs a rack middleware into your application which renders
a different `/robots.txt` based on the request's domain.

It looks in `config/robots/` for a file named `<DOMAIN>.txt`, for example,
`config/robots/www.example.com.txt`. A server restart is required to pick up
changes.

If no file exists for the requests domain, it renders a default

```
# Robots not allowed on this domain
User-Agent: *
Disallow: /
```

## Contributing

1. Fork it ( http://github.com/freerunningtech/laws_of_robots_txt/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
