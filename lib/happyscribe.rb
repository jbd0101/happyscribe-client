require "happyscribe/version"
require 'net/http'
require 'uri'
require 'json'
require "securerandom"
module Happyscribe
  class Error < StandardError; end
  # Your code goes here...
  class Transcript
    def initialize(key)
      @api_key = key
      @base = "https://www.happyscribe.co/api/v1"
      @auth_header = "Authorization: Bearer #{@api_key}"
    end
    def create(url,title="",language="fr-FR")
      endpoint = "#{base}/transcriptions"
      uri = URI.parse("https://www.happyscribe.co/api/v1/transcriptions")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Authorization"] = "Bearer bOlY4B0C9ZpnNrmmWtj6PAtt"

      request.body = JSON.dump({
        "transcription" => {
          "name" => (title=="" ? ),
          "language" => language,
          "tmp_url" => url
        }
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

    end
  end
end
