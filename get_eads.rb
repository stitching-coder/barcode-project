require 'archivesspace/client'
require 'net/http'
require 'json'
require 'uri'

def authenticated_http_get_request(uri,token)
  uri = URI.parse(uri)
  request = Net::HTTP::Get.new(uri)
  request["X-Archivesspace-Session"] = token

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end
end

config = ArchivesSpace::Configuration.new({
  base_uri: "",
  base_repo: "",
  username: "",
  password: "",
  page_size: 50,
  throttle: 0,
  verify_ssl: false,
  timeout: 60
})

client = ArchivesSpace::Client.new(config).login

client.repository(2)

# ids = ["1678", "85", "3828", "2361", "3"]
ids = ["3"]
# Get an EAD representation of a Resource
ids.each do |i|
  uri = ""
  response = authenticated_http_get_request(uri, client.token)
  File.write("#{i}.xml", response.body)
end
