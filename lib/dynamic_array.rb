require_relative "static_array"
require 'byebug'

class DynamicArray
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
  def []=(index, value)
    raise "index out of bounds" if @store[index].nil?
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @store.empty?
    popped = @store[@length-1]
    @length -= 1
    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == @capacity && @capacity != 0
      resize!
    end 
    if @store.empty?
      # debugger
      @store += [val]
      @length += 1
    else
      @store += [val]
      @length += 1
    end
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @store.empty?
    shifted = @store[0]
    @length -= 1
    @store.map.with_index do |el,i|
      
      el = @store[i+1] if i == @length
    end
    @store = @store[1..-1]
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length == @capacity && @capacity != 0
      resize!
    end
    @store = [val] + @store
    @length += 1
    
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    oldstore = @store
    storeobj = StaticArray.new(@length*2)
    @store = storeobj.store
    @capacity = @capacity * 2

    @store.map.with_index do |el,i|
      el = oldstore[i]
    end
    # debugger
  end
end
