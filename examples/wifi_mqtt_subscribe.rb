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

# Main loop
loop do
  # If any messages on the queue, read and print them all.
  topic, message = mqtt.read
  while (message) do
    puts "Topic: #{topic}, message: #{message}"
    topic, message = mqtt.read
  end

  # Wait before checking again.
  sleep 0.5
end

# Send a message using another MQTT client or a site like:
# https://testclient-cloud.mqtt.cool/
