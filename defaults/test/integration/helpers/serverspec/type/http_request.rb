require 'net/http'

module Serverspec
  module Type
    class HTTPRequest < Base
      def initialize(uri, args = {})
        super(uri)
        @uri = URI(uri)
        @opt = args[:opt] || { open_timeout: 1, read_timeout: 1 }
        @form_data = args[:form_data]
        @method = args[:method] || @form_data.nil? ? :http_get : :http_post
        @basic_auth = args[:basic_auth]
        @quiet = args[:quiet] || false

        if @uri.scheme == 'https'
          @opt[:use_ssl] ||= true
          @opt[:verify_mode] ||= OpenSSL::SSL::VERIFY_NONE
        end
      end

      def successful?
        send(@method) { |response| response.is_a?(Net::HTTPSuccess) || response.is_a?(Net::HTTPRedirection) }
      end

      def status_code
        send(@method) { |response| response.code.to_i }
      end

      def response_body
        send(@method) { |response| response.body }
      end

      def response_headers
        send (@method) { |response| response.to_hash }
      end

      private

      def setup_basic_auth(request)
        unless @basic_auth.nil?
          request.basic_auth(@basic_auth[:username], @basic_auth[:password])
        end
      end

      def on_request_failed(exception)
        unless @quiet
          $stderr.puts "HTTP request failed: #{exception.message}"
          $stderr.puts "Backtrace: #{exception.backtrace.join("\n")}"
        end
      end

      def http_get
        begin
          Net::HTTP.start(@uri.host, @uri.port, opt = @opt) do |http|
            request = Net::HTTP::Get.new(@uri.request_uri)
            setup_basic_auth(request)
            yield http.request(request)
          end
        rescue SocketError, Errno::ECONNREFUSED, Errno::EHOSTUNREACH => e
          on_request_failed(e)
        end
      end

      def http_post
        begin
          Net::HTTP.start(@uri.host, @uri.port, opt = @opt) do |http|
            request = Net::HTTP::Post.new(@uri.request_uri)
            request.form_data = @form_data
            setup_basic_auth(request)
            yield http.request(request)
          end
        rescue SocketError, Errno::ECONNREFUSED, Errno::EHOSTUNREACH => e
          on_request_failed(e)
        end
      end
    end

    def http_request(uri, args = {})
      HTTPRequest.new(uri, args)
    end
  end
end

include Serverspec::Type
