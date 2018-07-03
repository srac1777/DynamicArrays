require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    storeobj = StaticArray.new(0)
    @store = storeobj.store
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if @store[index].nil?
    @store[index]
  end

  # O(1)
  def []=(index, val)
    raise "index out of bounds" if @store[index].nil?
    @store[index] = value
  end

  # O(1)
  def pop
  end

  # O(1) ammortized
  def push(val)
  end

  # O(1)
  def shift
  end

  # O(1) ammortized
  def unshift(val)
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
  end
end
