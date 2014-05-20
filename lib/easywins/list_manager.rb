module Easywins
  class ListManager
    LIST_LOCATION = "#{File.dirname(__FILE__)}/../../paths.txt"
    DOWNLOAD_URL  = 'https://raw.githubusercontent.com/pwnwiki/webappurls/gh-pages/webappurls.txt'

    class UpdateError < StandardError; end

    def self.file_exists?
      File.exists?(LIST_LOCATION)
    end

    def self.update_file!
      download = download_file!
      if download.code != 200 || download.body.size.zero?
        raise UpdateError.new("Unable to download list from #{DOWNLOAD_URL}")
      end
      write_to_file!(download.body)
    end

    def self.get_list
      sanitize_list(File.read(LIST_LOCATION))
    end

  private

    def self.download_file!
      http_client.do_get(DOWNLOAD_URL)
    end

    def self.write_to_file!(content)
      open(LIST_LOCATION, 'w') do |f|
        f.puts(sanitize_list(content).join("\n"))
      end
    end

    def self.sanitize_list(list)
      list.split("\n").map { |l| l.strip }.delete_if { |l| l.empty? || !l.start_with?('/') }
    end

    def self.http_client
      @http_client ||= Easywins::HttpClient.new
    end
  end
end
