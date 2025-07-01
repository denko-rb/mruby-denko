module Kernel
  def sleep(time)
    ESP32::System.delay(time * 1000)
  end
end
