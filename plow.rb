require 'dino'
require 'json'

## Begin Setup
board    = Dino::Board.new(Dino::TxRx::Serial.new)

@button_1 = Dino::Components::Button.new(pin: 2, board: board)
@button_2 = Dino::Components::Button.new(pin: 3, board: board)
@button_3 = Dino::Components::Button.new(pin: 4, board: board)
@button_4 = Dino::Components::Button.new(pin: 5, board: board)
@button_5 = Dino::Components::Button.new(pin: 6, board: board)
@button_6 = Dino::Components::Button.new(pin: 7, board: board)

@led_1    = Dino::Components::Led.new(pin: 8,  board: board)
@led_2    = Dino::Components::Led.new(pin: 9,  board: board)
@led_3    = Dino::Components::Led.new(pin: 10, board: board)
@led_4    = Dino::Components::Led.new(pin: 11, board: board)
@led_5    = Dino::Components::Led.new(pin: 12, board: board)
@led_6    = Dino::Components::Led.new(pin: 13, board: board)

def turn_all_off
  (1..6).each{|n| turn_off(n)}
end

def turn_on(number)
  led(number).send(:on)
end

def turn_off(number)
  led(number).send(:off)
end

def led(number)
  instance_variable_get("@led_#{number}")
end

def check_for_running_timer
  timer_status = JSON.parse(`curl http://localhost:4567/running_timer`)
  if timer_status["running"] == true
    turn_on(timer_status["button"])
  end
end


## Set button reactions
@button_1.up do
  react_with_number(1)
end

@button_2.up do
  react_with_number(2)
end

@button_3.up do
  react_with_number(3)
end

@button_4.up do
  react_with_number(4)
end

@button_5.up do
  react_with_number(5)
end

@button_6.up do
  react_with_number(6)
end

def react_with_number(number)
  response = JSON.parse(`curl http://localhost:4567/toggle?button=#{number}`)
  puts response

  if response["success"]
    if response["on"] == true
      turn_all_off
      turn_on(number)
    else
      turn_all_off
    end
  end
end

## End of Setup

check_for_running_timer
puts "Ready to get to work!"

# hang the code so it will listen to button clicks forever
sleep
