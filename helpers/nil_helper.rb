class NilClass
  def try(*args)
    nil
  end

  def present?
    false
  end
end

class Object
  def try(*a, &b)
    if a.empty? && block_given?
      yield self
    else
      public_send(*a, &b) if respond_to?(a.first)
    end
  end

  def present?
    true
  end
end
