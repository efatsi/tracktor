require 'dino'

board = Dino::Board.new(Dino::TxRx::Serial.new)

button_1 = Dino::Components::Button.new(pin: 7, board: board)
button_2 = Dino::Components::Button.new(pin: 6, board: board)
button_3 = Dino::Components::Button.new(pin: 5, board: board)
button_4 = Dino::Components::Button.new(pin: 4, board: board)
button_5 = Dino::Components::Button.new(pin: 3, board: board)
button_6 = Dino::Components::Button.new(pin: 2, board: board)

button_1.up do
  # puts "1"
  `curl http://localhost:4567/toggle?timer=1`
end

button_2.up do
  # puts "2"
  `curl http://localhost:4567/toggle?timer=2`
end

button_3.up do
  # puts "3"
  `curl http://localhost:4567/toggle?timer=3`
end

button_4.up do
  # puts "4"
  `curl http://localhost:4567/toggle?timer=4`
end

button_5.up do
  # puts "5"
  `curl http://localhost:4567/toggle?timer=5`
end

button_6.up do
  # puts "6"
  `curl http://localhost:4567/toggle?timer=6`
end

puts "Ready to get to work!"

# hang the code so it will listen to button clicks forever
sleep
