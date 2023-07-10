TOPIC = "mruby-denko-mqtt"

# Wi-Fi connection
wifi = WiFi.new
wifi.on_connected    { |ip| puts "Wi-Fi connected with IP: #{ip}" }
wifi.on_disconnected {      puts "Wi-Fi disconnected" }
wifi.connect('SSID', 'password')

# MQTT connection
mqtt = MQTT::Client.new('test.mosquitto.org', 1883)
mqtt.connect

# Subscribe to the topic.
mqtt.subscribe(TOPIC)

# Wait for messages and print them.
# mqtt.get blocks until a message is received.
loop do
  topic, message = mqtt.get
  puts "Topic: #{topic}, message: #{message}"
end

# Send a message using another MQTT client or a site like:
# https://testclient-cloud.mqtt.cool/
