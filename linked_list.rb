class Node
  attr_accessor :value, :next_node
  def initialize
    @value = nil
    @next_node = nil
  end
end

class LinkedList
  #include Enumerable
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
      @tail = new_tail
      @size += 1
    else
      @tail.next_node = new_tail
      @tail = new_tail
      @size +=1
    end
  end

  def prepend(value)
    new_head = Node.new
    new_head.value = value
    if @head.nil?
      @head = new_head
      @tail = new_head
      @size += 1
    else
      new_head.next_node = @head
      @head = new_head
      @size += 1
    end
  end

  def pop
    return nil if tail.nil?
    entry = @tail
    penultimate_node = self.at(size-2)
    penultimate_node.next_node = nil
    @tail = penultimate_node
    entry
  end

  def at(index)
    self.each_node_with_index{|node,position|
      return node if position == index
    }
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
        self.each_node do |node|
            yield(node, index)
            index += 1
        end
  end
end

list = LinkedList.new
5.downto(0) {|n| 
  list.append(n)
}

6.upto(15) {|n| 
  list.prepend(n)
}

list.each_node_with_index {|node, index| 
  puts "node value: #{node.value}, position: #{index}"}

p list.tail

p list.pop

list.each_node_with_index {|node, index| 
  puts "node value: #{node.value}, position: #{index}"}

p list.tail