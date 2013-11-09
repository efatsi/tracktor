class LightShow < Struct.new(:led_1, :led_2, :led_3, :led_4, :led_5, :led_6)

  def kick_it
    send("act_#{rand(1..9)}")

    turn_all_off
    sleep(0.1)
    turn_all_on
    sleep(0.2)
    turn_all_off
    sleep(0.4)
  end

  def act_1
    (1..6).each{|n| turn_on(n); sleep(0.1)}
    turn_all_off
    (1..6).each{|n| turn_on(7 - n); sleep(0.1)}
  end

  def act_2
    (1..6).each{|n| turn_on(n); sleep(0.1)}
    (1..6).each{|n| turn_off(n); sleep(0.1)}
  end

  def act_3
    (1..6).each{|n| turn_on(7 - n); sleep(0.1)}
    turn_all_off
    (1..6).each{|n| turn_on(n); sleep(0.1)}
  end

  def act_4
    (1..6).each{|n| turn_on(7 - n); sleep(0.1)}
    (1..6).each{|n| turn_off(7 - n); sleep(0.1)}
  end

  def act_5
    turn_on(3)
    turn_on(4)
    sleep(0.2)
    turn_on(2)
    turn_on(5)
    sleep(0.2)
    turn_on(1)
    turn_on(6)

    sleep(0.2)

    turn_off(6)
    turn_off(1)
    sleep(0.2)
    turn_off(2)
    turn_off(5)
    sleep(0.2)
    turn_off(3)
    turn_off(4)
  end

  def act_6
    turn_on(1)
    turn_on(6)
    sleep(0.2)
    turn_on(2)
    turn_on(5)
    sleep(0.2)
    turn_on(3)
    turn_on(4)

    sleep(0.2)

    turn_off(3)
    turn_off(4)
    sleep(0.2)
    turn_off(2)
    turn_off(5)
    sleep(0.2)
    turn_off(1)
    turn_off(6)
  end

  def act_7
    turn_on(1)
    sleep(0.1)
    turn_on(6)
    sleep(0.1)

    turn_on(2)
    sleep(0.1)
    turn_on(5)
    sleep(0.1)

    turn_on(3)
    sleep(0.1)
    turn_on(4)
    sleep(0.1)

    turn_off(1)
    sleep(0.1)
    turn_off(6)
    sleep(0.1)

    turn_off(2)
    sleep(0.1)
    turn_off(5)
    sleep(0.1)

    turn_off(3)
    sleep(0.1)
    turn_off(4)
    sleep(0.1)
  end

  def act_8
    turn_on(3)
    sleep(0.1)
    turn_on(4)
    sleep(0.1)

    turn_on(2)
    sleep(0.1)
    turn_on(5)
    sleep(0.1)

    turn_on(1)
    sleep(0.1)
    turn_on(6)
    sleep(0.1)

    turn_off(3)
    sleep(0.1)
    turn_off(4)
    sleep(0.1)

    turn_off(2)
    sleep(0.1)
    turn_off(5)
    sleep(0.1)

    turn_off(1)
    sleep(0.1)
    turn_off(6)
    sleep(0.1)
  end

  def act_9
    turn_on(3)
    sleep(0.15)
    turn_off(3)

    turn_on(4)
    sleep(0.15)
    turn_off(4)

    turn_on(2)
    sleep(0.15)
    turn_off(2)

    turn_on(5)
    sleep(0.15)
    turn_off(5)

    turn_on(1)
    sleep(0.15)
    turn_off(1)

    turn_on(6)
    sleep(0.15)
    turn_off(6)

    turn_on(1)
    sleep(0.15)
    turn_off(1)

    turn_on(6)
    sleep(0.15)
    turn_off(6)

    turn_on(2)
    sleep(0.15)
    turn_off(2)

    turn_on(5)
    sleep(0.15)
    turn_off(5)

    turn_on(3)
    sleep(0.15)
    turn_off(3)

    turn_on(4)
    sleep(0.15)
    turn_off(4)
  end

  def turn_all_off
    (1..6).each{|n| turn_off(n)}
  end

  def turn_all_on
    (1..6).each{|n| turn_on(n)}
  end

  def turn_on(number)
    led(number).send(:on)
  end

  def turn_off(number)
    led(number).send(:off)
  end

  def led(number)
    [
      led_1,
      led_2,
      led_3,
      led_4,
      led_5,
      led_6,
    ][number - 1]
  end

end
