require_relative "static_array"
require 'byebug'

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
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
    raise "index out of bounds" if @length == 0
    to_return = @store[((@start_idx + @length) % @capacity)-1]
    @length -= 1
    to_return
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[((@start_idx + @length) % @capacity)] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    to_return = @store[@start_idx]
    
  end

  # O(1) ammortized
  def unshift(val)

  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index = 0)
    return false if length == 0
    return false if index >= length
    return false if index < 0
    true
  end

  def resize!
  end
end
