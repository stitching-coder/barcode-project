import json, requests, authenticate

baseURL, headers = authenticate.login()

PAGE_SIZE = 250

records = []
page = 1
while page <= 579:
  try:
    endpoint = '/repositories/2/top_containers?page=' + str(page) + '&page_size=' + str(PAGE_SIZE)
    output = requests.get(baseURL + endpoint, headers=headers).json()
    print('Got result page: ' + str(page))
    f=open('topContainers'+str(page)+'.json', 'w')
    json.dump(output['results'], f)
    f.close()
    page += 1

    for value in output['results']:
      if len(value['collection']) == 1:
        print(str(value['uri']) + ', ' + str(value['collection'][0]['ref']) + ', ' + str(value['long_display_string']))
      elif 'created_for_collection' in value:
        print(str(value['uri']) + ', ' + str(value['created_for_collection']) + ', ' + str(value['long_display_string']))
      else:
        print(str(len(value['collection'])) + ' collections attached to ' + str(value['uri']))
  except requests.exceptions.RequestException as e:
    print ("Invalid URL. Try running the script again with different repository and/or resource numbers.")
    exit()
