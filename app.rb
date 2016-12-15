require 'json'
require 'csv'
require 'sinatra'

tomorrow = Date.today + 1
today = tomorrow.strftime('%Y-%m-%d')

game = 'None'

CSV.foreach("./schedule.csv") do |row|
	if row[6] == 'PIT' && today == row[5].split("T")[0]
		puts row[5]
		event = row[10] + ' @ ' + row[6]
		time = DateTime.parse(row[5]).new_offset('-05:00')
		time = time.strftime('%I:%M:%S %p')

		game = event + ' ' + time
	end
end

get '/' do
	ret = Hash.new
	item = Hash.new
	item['text'] = game
	item['type'] = 2

	ret['item'] = []

	ret['item'].push item

	ret.to_json
end
