import json, requests, csv, authenticate

baseURL, headers = authenticate.login()

# open csv and generate dict
reader = csv.DictReader(open('example_barcodes_file'))

# GET each top_container listed in top_containers and add to records
print ('The following barcodes have been updated in ArchivesSpace:')
for row in reader:
	uri = row['uri']
	output = requests.get(baseURL + uri, headers=headers).json()
	output['barcode'] = row['barcode']
	post = requests.post(baseURL + uri, headers=headers, data=json.dumps(output)).json()
	print (post)
