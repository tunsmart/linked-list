# frozen_string_literal: true

class Node
  attr_accessor :value, :next_node

  def initialize
    @value = nil
    @next_node = nil
  end
end

class LinkedList
  # include Enumerable
  attr_reader :size, :tail

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    new_tail = Node.new
    new_tail.value = value
    if @tail.nil?
      @head = new_tail
    else
      @tail.next_node = new_tail
    end
    @tail = new_tail
    @size += 1
  end

  def prepend(value)
    new_head = Node.new
    new_head.value = value
    if @head.nil?
      @head = new_head
      @tail = new_head
    else
      new_head.next_node = @head
      @head = new_head
    end
    @size += 1
  end

  def pop
    return nil if tail.nil?

    entry = @tail
    penultimate_node = at(size - 2)
    penultimate_node.next_node = nil
    @tail = penultimate_node
    entry
  end

  def at(index)
    each_node_with_index do |node, position|
      return node if position == index
    end
  end

  def each_node
    return nil unless @head

    current_node = @head
    until current_node.next_node.nil?
      temp_node = current_node
      yield temp_node
      current_node = temp_node.next_node
    end
  end

  def each_node_with_index
    return nil unless @head

    index = 0
    each_node do |node|
      yield(node, index)
      index += 1
    end
  end
end

list = LinkedList.new
5.downto(0) do |n|
  list.append(n)
end

6.upto(15) do |n|
  list.prepend(n)
end

list.each_node_with_index do |node, index|
  puts "node value: #{node.value}, position: #{index}"
end

p list.tail

p list.pop

list.each_node_with_index do |node, index|
  puts "node value: #{node.value}, position: #{index}"
end

p list.tail
