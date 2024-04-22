import json, requests, csv, authenticate

baseURL, headers = authenticate.login()

# Open file with top container uris
f = open('top_containers_to_date.txt', 'r')

# DELETE each top_container listed in the txt file
for uri in f:
  print(uri)
  response = requests.delete(baseURL + uri, headers=headers)
  print(response)
