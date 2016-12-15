require 'csv'
require 'gmail'

tomorrow = Date.today + 1
today = tomorrow.strftime('%Y-%m-%d')

CSV.foreach("./schedule.csv") do |row|
	if row[6] == 'PIT' && today == row[5].split("T")[0]
		puts row[5]
		event = row[10] + ' @ ' + row[6]
		time = DateTime.parse(row[5]).new_offset('-05:00')
		time = time.strftime('%I:%M:%S %p')

		puts event + ' ' + time

		gmail = Gmail.new(ENV['EMAIL'], ENV['PASS'])

		gmail.deliver do
		  to ENV['TO_EMAIL']
		  subject 'Hockey Game'
		  text_part do
		    body event + ' ' + time 
		  end
		  html_part do
		    content_type 'text/html; charset=UTF-8'
		    body  event + ' ' + time
		  end
		end
	end	
end
