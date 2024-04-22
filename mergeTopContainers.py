import json, requests, csv, authenticate

baseURL, headers = authenticate.login()

# open csv and generate dict
# Format: target_uri,victim_uris - separated by semi-colon
# /repositories/2/top_containers/1, /repositories/2/top_containers/2;/repositories/2/top_containers/3;/repositories/2/top_containers/4
reader = csv.DictReader(open('top_containers_to_merge'))

# POST merge top_container listed in the csv
for row in reader:
	target = row['target_uri']
	victim = row['victim_uris'].split(';')
	victims = []
	for v in victim:
		victims.append({ 'ref': v})

	uri = 'merge_requests/top_container'
	params = { 'repo_id': '2' }
	json_data = {
		'uri': 'merge_requests/top_container',
		'target': {
            'ref': row['target_uri'],
        },
		'victims': victims,
    }
	post = requests.post(baseURL + uri, params=params, headers=headers, json=json_data)
	print (post)
