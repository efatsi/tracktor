require 'dino'

board    = Dino::Board.new(Dino::TxRx::Serial.new)

button_1 = Dino::Components::Button.new(pin: 7, board: board, pullup: true)
button_2 = Dino::Components::Button.new(pin: 6, board: board, pullup: true)
button_3 = Dino::Components::Button.new(pin: 5, board: board, pullup: true)
button_4 = Dino::Components::Button.new(pin: 4, board: board, pullup: true)
button_5 = Dino::Components::Button.new(pin: 3, board: board, pullup: true)
button_6 = Dino::Components::Button.new(pin: 2, board: board, pullup: true)
