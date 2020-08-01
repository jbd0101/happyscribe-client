require "happyscribe/version"
require 'net/http'
require "open-uri"
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
      @auth = "Bearer #{@api_key}"
    end
    def create(url,title="",language="fr-FR")
      endpoint = "#{@base}/transcriptions"
      uri = URI.parse(endpoint)
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Authorization"] = @auth

      request.body = JSON.dump({
        "transcription" => {
          "name" => (title=="" ? SecureRandom.alphanumeric : title ),
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
      return JSON.parse response.body
    end
    def list
      endpoint = "#{@base}/transcriptions"
      uri = URI.parse(endpoint)
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = @auth

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      return JSON.parse response.body
    end
    def retrieve(id)
      endpoint = "#{@base}/transcriptions/#{id}"

      uri = URI.parse(endpoint)
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = @auth

      req_options = {
        use_ssl: uri.scheme == "https",
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      return JSON.parse(response.body)
    end
    def create_export(id,format="txt",timestamps=false,speakers=false,comments=false,highlights=false)
      uri = URI.parse("#{@base}/exports")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Authorization"] = @auth
      request.body = JSON.dump({
        "export" => {
          "format" => format,
          "show_timestamps" => timestamps,
          "show_speakers" => speakers,
          "show_comments" => comments,
          "show_highlights" => highlights,
          "transcription_ids" => [
            id
          ]
        }
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      return JSON.parse response.body
    end
    def create_multiple_export(ids,format="txt",timestamps=false,speakers=false,comments=false,highlights=false)
      uri = URI.parse("#{@base}/exports")
      request = Net::HTTP::Post.new(uri)
      request.content_type = "application/json"
      request["Authorization"] = @auth
      request.body = JSON.dump({
        "export" => {
          "format" => format,
          "show_timestamps" => timestamps,
          "show_speakers" => speakers,
          "show_comments" => comments,
          "show_highlights" => highlights,
          "transcription_ids" => ids
        }
      })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      return JSON.parse response.body
    end
    def retrieve_export(export_id)
      endpoint = "#{@base}/exports/#{export_id}"
      uri = URI.parse(endpoint)
      request = Net::HTTP::Get.new(uri)
      request["Authorization"] = @auth

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      return JSON.parse response.body
    end
    def export_in_txt(transcription)
      export = create_export(transcription,"txt")["id"]
      sleep(5)
      while true
        retrieved = retrieve_export(export)
        if(retrieved["state"]=="ready")
          break
        else
          sleep(2)
        end
      end
      txt = URI.parse(retrieved["download_link"]).open.read.force_encoding("utf-8")
      return txt
    end
  end
end
