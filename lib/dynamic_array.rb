require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length
  attr_accessor :capacity, :store

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    # debugger
    raise "index out of bounds" unless check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" unless check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0

    toreturn = @store[length]
    @length -= 1
    toreturn
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == capacity
      
      resize!
    end
    @length += 1
    @store[length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0

    toreturn = @store[0]
    i = 0
    while i < @length
      @store[i] = @store[i + 1]
      i += 1
    end
    length -=1
    
    toreturn
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if length == capacity
      resize!
    end
    
    p @store
    i = 0
    while i < @store.length - 1
      
      @store[i+1] = @store[i]
      i+=1
    end
    @store[0] = val
    
    # debugger
    @length +=1
    
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    return false if index >= length
    return false if index < 0
    return false if length == 0
    true
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    # debugger
    oldstore = @store
    @capacity *= 2
    @store = StaticArray.new(@capacity)
    i = 0
    while i < @length
      @store[i] = oldstore[i]
      i += 1
    end
  end
end
