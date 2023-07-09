# Wait a bit for startup to complete.
sleep(0.5)

string1 = "testing "
string2 = "1,2,3..."

# mruby has access to a 192 kB partition of the ESP32's on-board flash memory.
# It's mounted at "/storage". This file is "/storage/main.rb".
puts "Writing to /storage/test.txt: \"#{string1}#{string2}\""
File.open('/storage/test.txt', 'w') { |f| f.write(string1) }
File.open('/storage/test.txt', 'a') { |f| f.write(string2) }

print "Read from /storage/text.txt: "
File.open('/storage/test.txt', 'r') { |f| f.each_line { |l| puts l } }
