import json

for n in range(1, 579):
  # Opening JSON file
  f = open('data/topContainers'+str(n)+'.json')

  # returns JSON object as a dictionary
  data = json.load(f)

  # Iterating through the json list
  for value in data:
  # if not value['long_display_string'].startswith('Box '):
    if len(value['collection']) == 1:
      print('One collection' + ', ' + str(value['uri']) + ', ' + str(value['collection'][0]['ref']) + ", \"" + str(value['long_display_string']) + "\"")
    elif len(value['collection']) == 0 and 'created_for_collection' in value:
      print('No collection attached but created for collection' + ', ' + str(value['uri']) + ', ' + str(value['created_for_collection']) + ", \"" + str(value['long_display_string']) + "\"")
    else:
      if len(value['collection']) == 0:
        print('No collection attached' + ', ' +  str(value['uri']))
      else:
        collection = []
        for v in value['collection']:
          collection.append(v['ref'])
        print('Multiple collections attached' + ', ' +  str(value['uri']) + ', ' + '; '.join(collection))
  
  # Closing file
  f.close()
