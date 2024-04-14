require 'archivesspace/client'
require 'csv'
require_relative 'http_requests'

# BASE_URI="https://uclalsc-staff.lyrasistechnology.org/api"
# BASE_REPO="2"
# USERNAME="lmcglohon"
# PASSWORD="emmaDix2@"
# base_uri: BASE_URI,
# base_repo: BASE_REPO,
# username: USERNAME,
# password: PASSWORD,

config = ArchivesSpace::Configuration.new({
  base_uri: "https://uclalsc-staff.lyrasistechnology.org/api",
  base_repo: "2",
  username: "lmcglohon",
  password: "emmaDix2@",
  page_size: 50,
  throttle: 0,
  verify_ssl: false,
  timeout: 60
})

client = ArchivesSpace::Client.new(config).login

req = HttpRequests.new(client.token)
url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/top_containers?all_ids=true"
response = req.authenticated_http_get_request(url)
top_containers = JSON.parse(response.body)
# puts top_containers.count

top_container = [1]
top_cs = []
# CSV.open("file.csv", 'wb') do |csv|
#   csv << ["indicator", "jsonmodel_type", "active_restrictions.each", "container_locations.each", "series.each", "collection.ref", "collection.identifier", "collection.display_string", "uri", "repository.ref", "restricted", "is_linked_to_published_record", "display_string", "long_display_string"]
  top_containers.each do |t|
    url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/top_containers/#{t}"
    response = req.authenticated_http_get_request(url)
    tc = JSON.parse(response.body)
    top_cs << tc
    # puts tc unless tc["container_locations"].empty?
    # csv << [tc["indicator"], tc["jsonmodel_type"], tc["active_restrictions"], tc["container_locations"], tc["series"], tc["collection"]["ref"], tc["collection"]["identifier"], tc["collection"]["display_string"], tc["uri"], tc["repository"]["ref"], tc["restricted"], tc["is_linked_to_published_record"], tc["display_string"], tc["long_display_string"]]
    # csv << [tc["indicator"], tc["jsonmodel_type"]]
  end
  puts top_cs
# end

# url = "https://uclalsc-staff.lyrasistechnology.org/api/location_profiles?all_ids=true"
# response = req.authenticated_http_get_request(url)
# lp = JSON.parse(response.body)
# puts lp[0].inspect

# url = "https://uclalsc-staff.lyrasistechnology.org/api/location_profiles/1"
# response = req.authenticated_http_get_request(url)
# lp = JSON.parse(response.body)
# puts lp[0].inspect


# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/top_containers/1"
# response = req.authenticated_http_get_request(url)
# tc = JSON.parse(response.body)
# puts tc.inspect



# top_containers.each do |t|
#   url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/top_containers/#{t}"
#   response = authenticated_http_get_request(url)
#   tc = JSON.parse(response.body)
#   puts tc unless tc["container_location"].nil?
# end;nil

# puts response.code
# locations = JSON.parse(response.body)

# url = "https://uclalsc-staff.lyrasistechnology.org/api/locations?page=1"
# response = unauthenticated_http_get_request(url)

# puts response.code
# locations = JSON.parse(response.body)

# ids = ["1678", "85", "3828", "2361", "3"]
# # Get a Resource
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resources/1678"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)

# # Get an EAD representation of a Resource
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resource_descriptions/1678.xml"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)

# # Get a MARC 21 representation of a Resource
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resources/marc21/1678.xml"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)

# # Get a list of Resources for a Repository
# # {"error"=>
# #   {"page"=>["Parameter required but no value provided"],
# #    "id_set"=>["Parameter required but no value provided"],
# #    "all_ids"=>["Parameter required but no value provided"]}} 
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resources"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)

# # Fetch tree information for the top-level resource record
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resources/1678/tree/root"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)

# # Get a CSV template useful for bulk-creating containers for archival objects of a resource
# # Saves the csv to file 'resource_1_top_container_creation.csv'
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resources/1678/templates/top_container_creation.csv"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)

# # Get Top Containers linked to a published resource and published archival objects contained within.
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resources/1678/top_containers"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)

# # Get the list of URIs of this published resource and all published archival objects contained within.
# # Ordered by tree order (i.e. if you fully expanded the record tree and read from top to bottom)
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resources/1678/ordered_records"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)

# # Get metadata for a MARC21 export
# url = "https://uclalsc-staff.lyrasistechnology.org/api/repositories/2/resources/marc21/1678.xml/metadata"
# response = authenticated_http_get_request(url)
# tc = JSON.parse(response.body)
