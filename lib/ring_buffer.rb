require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" unless check_index(index)
    @store[index] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if length == 0

    toreturn = @store[length]
    @length -= 1
    toreturn
  end

  # O(1) ammortized
  def push(val)
    if @length == capacity
      
      resize!
    end
    @length += 1
    @store[length] = val
  end

  # O(1)
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

  # O(1) ammortized
  def unshift(val)
    if length == capacity
      resize!
    end
    
    # p @store
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
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index = 0)
    return false if index >= length
    return false if index < 0
    return false if length == 0
    true
  end

  def resize!
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
