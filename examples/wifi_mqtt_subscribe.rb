TOPIC = "mruby-denko-mqtt"

# Wi-Fi connection
wifi = WiFi.new
wifi.on_connected    { |ip| puts "Wi-Fi connected with IP: #{ip}" }
wifi.on_disconnected {      puts "Wi-Fi disconnected" }
wifi.connect('SSID', 'password')

# MQTT connection
mqtt = MQTT::Client.new('test.mosquitto.org', 1883)
mqtt.connect

# Subscribe to a topic with a callback as a block.
mqtt.subscribe(TOPIC) do |message|
  puts "Topic: #{TOPIC}, message: #{message}"
end

# Message receive is event driven, so main loop can do whatever.
loop do
  sleep 1
end

# Send a message using another MQTT client or a site like:
# https://testclient-cloud.mqtt.cool/
