# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'
require 'byebug'

# [5, 3, 2, 7, 6, 5, 4, 3, 2, 1, 8]
# max = 7

# maxArray = [5].
# if el < maxArray { 
#   while el > maxArray.last {
#     maxArray.pop
#   }
#   maxArray.push(el)
# }

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @maxArray = []
    @max = nil
  end

  def enqueue(val)
    @store.push(val)
    @max = val if @max.nil? || val > @max
    if @maxArray.empty?
      @maxArray << val 
    else
      if val < @max  
          while @maxArray.length > 0 && val > @maxArray.last 
                @maxArray.pop
          end
          @maxArray.push(val)
      end
    end

  end

  def dequeue
    el = @store.shift
    if el == @max
      @maxArray.shift
      @max = @maxArray[0]
    end
    el
  end

  def max
    @max
  end

  def length
    @store.length
  end

end
