require 'ruby-debug'
module DataStructure
	class Heap	
		attr_reader :heap
		attr_reader :size
		
		def initialize()
			@size = 0
			@heap = Array.new()
		end
		
		def include(element)
			@heap << element
			max_heapify(0)
			@size=(@size + 1) 
		end
		
		def remove(position)
			@heap.delete_at(position)
			@size=(@size - 1)
		end
		
		def parent(i)
			if i%2 == 0
				parent = (i/2)-1
			else
				parent = (i/2)
			end
			
			parent = 0 if i <= 2
			return parent	
		end
		
		def left(i)
			return (2*i)+1
		end
		
		def rigth(i)
			return (2*i)+2
		end
		
		def build_max_heap
			(((heap.length-1)/2)-1).downto(0) do |number|
				max_heapify(number)
			end
		end
		
		def max_heapify(i)
			left = left(i)
			rigth = rigth(i)
			if left < @size && @heap[left] > @heap[i]
				largest = left
			else
				largest = i	
			end
			
			if rigth < @size && @heap[rigth] > @heap[largest]
				largest = rigth
			end
			
			if largest != i
				aux = @heap[i]
				@heap[i] = @heap[largest]
				@heap[largest] = aux
				max_heapify(largest)
			end
		end
				
		private 
			def heap=(value)
				@heap = value
			end
			
			def size=(value)
				@size = value
			end
	end

	class PriorityQueue
		attr_reader :queue
		
		def initialize
			@queue = Heap.new
		end
	
		def heap_maximum
			@queue.heap[0]
		end
		
		def extract_max
			if @queue.size < 1
				raise "empty heap"
			end
			max = @queue.heap[0]
			@queue.heap[0] = @queue.heap[@queue.size-1]
			@queue.remove(@queue.size-1)
			@queue.max_heapify(0)
			return max
		end
		
		def increase_key(pos, new_key)
			if @queue.heap[pos] > new_key
				raise "New Key value can not has a value less than old value"
			end
			@queue.heap[pos] = new_key
			while pos > 0 && @queue.heap[pos] > @queue.heap[@queue.parent(pos)]
				aux = @queue.heap[pos]
				@queue.heap[pos] = @queue.heap[@queue.parent(pos)]
				@queue.heap[@queue.parent(pos)] = aux
				pos = queue.parent(pos)
			end
		end
		
		private
			def queue=(value)
				@queue = value
			end
	end
	
	class Stack
		def initialize()
			@stack = Array.new
			@top = -1
		end
		
		def empty?
			return @top == -1
		end
		
		def push(element)
			@top = @top + 1 
			@stack[@top] = element
		end
		def pop
			if @top < 0
				raise "Stack Underflow"
			end
			element = @stack[@top]
			@top = @top - 1
			return element
		end
	end
	
	class Queue
		def initialize
			@queue_size = 10
			@queue = Array.new(@queue_size)
			@head = -1
			@tail = 0
		end
		
		def enqueue(element)
			if @head == @queue_size
				@head = -1
				@tail = 0
			end
			
			if(@tail == @queue_size)
				increase_queue_size
			end		
			
			@queue[@tail] = element
			@tail = @tail +1
			
			if @head == -1
			 @head = 0
			end
		end
		
		def dequeue
			if(@head == @tail || @head == -1)
				raise "Empty Queue"
			end
			element = @queue[@head]
			@head = @head + 1
			return element
		end
		
		private 
			def increase_queue_size
				queue_aux = Array.new(@queue_size*2)
				for i in 0...@queue.length
					queue_aux[i] = @queue[i]
				end
				@queue_size = @queue_size*2
				@queue = queue_aux
			end
	end
	
	class DoubleUnsortedLinkedList
		def initialize
			@head = nil
		end
		
		def header
			@head
		end
		
		def search(element)
			position = @head
			while position.nil? == false && position.element != element
				position = position.next
			end
			return position
		end
		
		def insert(element)
			node = DoubleLinkedObject.new
			node.next = @head
			node.element = element
			node.prev = nil
			if @head != nil
				@head.prev = node
			end
			@head = node
		end
		
		def delete(element)
			node = search(element)
			if node != nil
				if node.prev != nil
					node.prev.next = node.next
				else
					@head = node.next
				end
				
				if node.next != nil
					node.next.prev = node.prev
				end
			end
		end
	end
	
	#Element should be an object with key attr, which is a integer
	class DirectAddressTable
		attr_reader :table
		
		def initialize
			@table = Array.new
		end
		
		def search(k)
			@table[k]
		end
		
		def insert(element)
			@table[element.key] = element
		end
		
		def delete(element)
			@table[element.key] = nil
		end
	
		private
			def table=(value)
				@table = value
			end
	end
	
	#Element should be an object with key attr, which is a integer
	class HashTable
		attr_reader :table
		
		def initialize
			@table = Array.new
		end
		
		def search(k)
			element = @table[hash_function(k)].search(k)
			return element
		end
		
		def insert(element)
			if @table[hash_function(element.key)].nil?
				@table[hash_function(element.key)] = DoubleUnsortedLinkedList.new()
			end
			@table[hash_function(element.key)].insert(element)
		end
		
		def delete(element)
			@table[hash_function(element.key)].delete(element)
		end
	
		private
			def table=(value)
				@table = value
			end
			
			def hash_function(key)
				return key
			end
	end
	
	class DoubleLinkedObject
		attr_accessor :prev, :next,:element
	end	
	
	class RedBlackTree
		attr_reader :root
		def initialize
			@root = nil
		end
		
		def insert(element)
			new_node = RedBlackBinaryNode.new
			new_node.element = element
			y = nil
			x = @root
			while x.nil? == false
				y = x
				if new_node.element < x.element
					x = x.left
				else
					x = x.right
				end
			end
			new_node.parent = y
			if y.nil?
				@root = new_node
			else
				if new_node.element < y.element
					y.left = new_node
				else
					y.right = new_node
				end
			end
			
			new_node.left = nil
			new_node.right = nil
			new_node.color = 1
			insert_fix_up(new_node)
		end
		
		private 
			def insert_fix_up(node)
				while node.parent.color == 1
					if node.parent == node.parent.parent.left
						y = node.parent.parent.right
						if y.color == 1
							node.parent.color = 0
							y.color = 0
							node.parent.parent.color = 1
							node = node.parent.parent
						else
							if node == node.parent.right
								node = node.parent
								left_rotate(node)
							end
							node.parent.color = 0
							node.parent.parent.color = 1
							right_rotate(node.parent.parent)
						end
					else
						y = node.parent.parent.left
						if y.color == 1
							node.parent.color = 0
							y.color = 0
							node.parent.parent.color = 1
							node = node.parent.parent
						else
							if node == node.parent.left
								node = node.parent
								right_rotate(node)
							end
							node.parent.color = 0
							node.parent.parent.color = 1
							left_rotate(node.parent.parent)
						end
					end
				end
				@root.color = 0
			end
			
			def left_rotate(node)
				right = node.right
				node.right = right.left
				if right.left.nil? == false
					right.left.parent = node
				end
				right.parent = node.parent
				if node.parent.nil?
					@root = right
				else
					if node == node.parent.left
						node.parent.left = right
					else
						node.parent.right = right
					end
				end
				right.left = node
				node.parent = right
			end
			
			def right_rotate(node)
				left = node.left
				node.left = left.right
				if left.right.nil? == false
					left.right.parent = node
				end
				left.parent = node.parent
				if node.parent.nil?
					@root = left
				else
					if node == node.parent.left
						node.parent.left = left
					else
						node.parent.right = left
					end
				end
				left.right = node
				node.parent = left
			end
			
			def root=(value)
				@root = value
			end
	end
	
	
	class BinarySearchTree
		attr_reader :root
		def initialize
			@root = nil
		end
		
		def search(key,iterative_version=false)
			if @root.nil?
				return nil
			else
				if iterative_version
					return tree_iterative_search(@root,key)
				else
					return tree_search(@root,key)
				end		
			end
		end
		
		def in_order()
			if @root.nil?
				puts "Tree is empty"
			else
				in_order_walk(@root)	
			end
		end
		
		def pre_order
			if @root.nil?
				puts "Tree is empty"
			else
				pre_order_walk(@root)
			end
		end
		
		def pos_order
			if @root.nil?
				puts "Tree is empty"
			else
				pos_order_walk(@root)
			end
		end
		
		def minimum(z)
			node = z
			while node.left.nil? == false
				node = node.left
			end
			return node
		end
		
		def maximum
			node = @root
			while node.right.nil? == false
				node = node.right
			end
			return node
		end
		
		def successor(node)
			if node.right.nil? == false
				return minimum(node.right)
			end
			parent = node.parent
			while parent.nil? == false && node == parent.right
				node = parent
				parent = parent.parent
			end
			return parent
		end
		
		def insert(element)
			new_node = BinaryNode.new
			new_node.element = element
			y = nil
			x = @root
			while x.nil? == false
				y = x
				if new_node.element < x.element
					x = x.left
				else
					x = x.right
				end
			end
			new_node.parent = y
			if y.nil?
				@root = new_node
			else
				if new_node.element < y.element
					y.left = new_node
				else
					y.right = new_node
				end
			end
		end

		def delete(node)
			if node.left.nil?
				transplant(node,node.right)
			else 
				if node.right.nil?
					transplant(node,node.left)
				else
					
					y = minimum(node.right)
					if y.parent != node
						transplant(y,y.right)
						y.right = node.right
						y.right.parent = y
					end
					transplant(node,y)
					y.left = node.left
					node.left.parent = y
				end
			end
		end
		
		private		
			def transplant(old,new)
				if old.parent.nil?
					@root = new
				else
					if old == old.parent.left
						old.parent.left = new
					else
						old.parent.right = new
					end
				end
				if new.nil? == false
					new.parent = old.parent
				end
			end
		
			def tree_iterative_search(node,key)
				while node.nil? == false && key != node.element
					if key < node.element
						node = node.left
					else
						node = node.right
					end
				end
				return node
			end
		
			def tree_search(node,key)
				if node.nil? || node.element == key
					return node
				end
				if key < node.element
					return tree_search(node.left,key)
				else
					return tree_search(node.right,key)
				end
			end
		
			def pre_order_walk(node)
				if node.nil? == false
					puts "#{node.element}"
					pre_order_walk(node.left)
					pre_order_walk(node.right)
				end
			end
						
			def in_order_walk(node)
				if node.nil? == false
					in_order_walk(node.left)
					puts "#{node.element}"
					in_order_walk(node.right)
				end
			end
			
			def pos_order_walk(node)
			
				if node.nil? == false
					pos_order_walk(node.left)
					pos_order_walk(node.right)
					puts "#{node.element}"
				end
			end
		
			def root=(value)
				@root = value
			end
	end
	
	class BinaryNode
		attr_accessor :parent, :left, :right, :element
	end
	
	class RedBlackBinaryNode
		attr_accessor :parent, :left, :right, :element, :color
	end
	
end
