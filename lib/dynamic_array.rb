require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_accessor :capacity, :store, :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
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
    to_return = @store[length]
    @length -= 1
    to_return
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity
    @length += 1
    @store[length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0
    to_return = @store[0]

    i = 0
    while i < length
      @store[i] = @store[i+1]
      i += 1
    end

    @length -=1
    to_return
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == capacity

    oldstore = @store.dup
    i = 1
    while i < length + 1
      
      i += 1
    end
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    return false if @length == 0
    return false if index > length
    return false if index < 0
    
    true
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    oldstore = @store.dup
    @store = StaticArray.new(capacity * 2)
    capacity *= 2

    oldstore.each_with_index do |el, i|
      @store[i] = el
    end

  end
end
