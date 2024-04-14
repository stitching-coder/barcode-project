require 'net/http'
require 'json'
require 'uri'

class HttpRequests
  def initialize(token)
    @token = token
  end

  def authenticated_http_get_request(url)
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri)
    request["X-Archivesspace-Session"] = @token

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

  def unauthenticated_http_get_request(url)
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri)

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end
end