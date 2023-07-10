TOPIC = "mruby-denko-mqtt"
MESSAGE = '{ "hello": "world." }'

# Wi-Fi connection
wifi = WiFi.new
wifi.on_connected    { |ip| puts "Wi-Fi connected with IP: #{ip}" }
wifi.on_disconnected {      puts "Wi-Fi disconnected" }
wifi.connect('SSID', 'password')

# MQTT connection
mqtt = MQTT::Client.new('test.mosquitto.org', 1883)
mqtt.connect

# Publish message and disconnect.
mqtt.publish(TOPIC, MESSAGE)
mqtt.disconnect

# Verify the message with another MQTT client or a site like:
# https://testclient-cloud.mqtt.cool/
