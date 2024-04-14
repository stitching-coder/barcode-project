class ParseItemRecords
  require 'csv'
  require 'json'

  # Columns
  # Barcode,Library,Location,Call Number,Item Call Number,Year,Volume,Description,Temporary Location,Status,Process type,Access Number,Receiving date
  # data = File.open(ARGV[0]).read
  # data_json = CSV.parse(data).to_json
  # puts data_json

  # Read JSON files
  # files = ["ACLU", "bradley", "neutra", "sheet_music", "susan_sontag"]
  files = ["ACLU"]
  files.each do |f|
    # Get item list
    file = File.read("#{f}_item.json")
    item_hash = JSON.parse(file)

    # Get top containers
    file = File.read("#{f}_top.json")
    top_hash = JSON.parse(file)

    # Item data
    item_with_keys = {}
    item_hash[0].each do |k|
      item_with_keys[k.to_sym] = []
    end
    item_hash[1..item_hash.count-1].each do |d|
      
    end
    puts item_with_keys.inspect
  end
end