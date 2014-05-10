# Easywins

![Easywins probing somewebsite.com](https://i.imgur.com/Qso3M12.png)

Easywins is a simple security tool that can probe a web server for common
paths that can be used for gathering information or for gaining a foothold
on the system.

The list of paths is taken from [@mubix's](https://twitter.com/mubix) crowd-sourced
list of common *easy win* paths: https://github.com/pwnwiki/webappurls

## Installation

    $ gem install easywins

## Usage

    Usage: easywins [options] base_url

    Probe a web server for common files and endpoints that are useful for gathering information or gaining a foothold.

    v0.1.0

    Options:
        -h, --help                       Show command line help
        -g, --get                        Use GET requests instead of HEAD (slower but stealthier)
        -s, --sleep                      Sleep between 0 and 10 seconds before each request
        -x, --spoof                      Spoof X-Forwarded-For header with random IP addresses
            --timeout SECONDS            Request timeout in seconds
                                         (default: 2.5)
        -r, --retries RETRIES            Number of retries on failed requests
                                         (default: 3)
        -t, --threads THREADS            Number of threads to use
                                         (default: 3)
            --no-verify                  Don't do SSL verification
            --no-redirect-check          Don't check if server redirects
            --no-404-check               Don't check if server responds with 404
            --no-color                   Don't colorize output
            --version                    Show help/version info

### Example:

    $ easywins --sleep --spoof --threads 5 http://somewebsite.com

## Contributing

1. Fork it ( https://github.com/michenriksen/easywins/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
