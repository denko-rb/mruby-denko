# Use submodules without Denko:: prefix.
include Denko

# Connect piezo-electric buzzer to this pin.
buzzer = PulseIO::Buzzer.new(pin: 4)

# Note frequencies.
C4 = 262
D4 = 294
E4 = 330

# Melody to play.
notes = [
        [E4, 1], [D4, 1], [C4, 1], [D4, 1], [E4, 1], [E4, 1], [E4, 2],
        [D4, 1], [D4, 1], [D4, 2],          [E4, 1], [E4, 1], [E4, 2],
        [E4, 1], [D4, 1], [C4, 1], [D4, 1], [E4, 1], [E4, 1], [E4, 1], [E4, 1],
        [D4, 1], [D4, 1], [E4, 1], [D4, 1], [C4, 4],
        ]
        
# Calculate length of one beat.
bpm = 180
beat_time = 60.to_f / bpm

# Play the melody.
notes.each do |note|
  buzzer.tone(note[0])
  sleep(note[1] * beat_time)
  
  # Drop frequency low for a bit to improve note separation. Will add a better way to do this.
  buzzer.tone(10)
end

buzzer.stop

# Low power sleep. After 10 seconds, the board reboots and reruns the app from the start.
# $board.deep_sleep(10)
