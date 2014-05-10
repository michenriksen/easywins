require 'securerandom'

module Easywins
  class Target

    attr_reader :base_url

    URL_REGEX      = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?\??$/
    REDIRECT_CODES = [300, 301, 302, 303, 305]

    class InvalidBaseUrlError < StandardError; end
    class TooManyRedirectsError < StandardError; end

    def initialize(base_url, options = {})
      @base_url = validate_and_normalize_url!(base_url)
      @options  = options
    end

    def request(path, use_get = false)
      url = "#{@base_url}#{path}"
      if use_get
        http_client.do_get(url, {}, :verify => @options[:verify])
      else
        http_client.do_head(url, {}, :verify => @options[:verify])
      end
    end

    def alive?
      response = request('/', true)
    rescue *HttpClient::HANDLED_EXCEPTIONS
      false
    end

    def redirects?
      final_url = validate_and_normalize_url!(follow_redirects!("#{@base_url}/"))
      if @base_url != final_url
        @base_url = final_url
        true
      else
        false
      end
    end

  private

    def validate_and_normalize_url!(url)
      url = "http://#{url}" unless url =~ /^https?:\/\//i
      raise InvalidBaseUrlError.new("#{url} is an invalid URL") unless valid_url?(url)
      normalized_url = url.dup
      use_ssl = (normalized_url =~ /^https/) || (normalized_url =~ /:443\b/)
      ends_with_slash = normalized_url =~ /\/$/

      normalized_url.chop! if ends_with_slash
      normalized_url.gsub!(/^https?:\/\//i, '')

      "http#{'s' if use_ssl}://#{normalized_url}".downcase
    end

    def follow_redirects!(url, redirects = 5)
      raise TooManyRedirectsError.new() if redirects.zero?
      response = http_client.do_get(url, {}, :verify => @options[:verify])
      if REDIRECT_CODES.include?(response.code)
        follow_redirects!(response.headers['location'], redirects-1)
      else
        url
      end
    end

    def valid_url?(url)
      url =~ URL_REGEX
    end

    def http_client
      @http_client ||= HttpClient.new(@options)
    end
  end
end
