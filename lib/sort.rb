require Dir.getwd+'\lib\data_structure.rb'
require 'ruby-debug'
module Sort
	def Sort.insertion_sort(elements_array)
		for j in 1...elements_array.length do
			key = elements_array[j]
			i = j-1
			while i >= 0 && elements_array[i] > key do
				elements_array[i+1] = elements_array[i]
				i = i - 1
			end
			elements_array[i+1] = key
		end
	end
	
	def Sort.heap_sort(array)
		array_length = array.length() -1
		heap = DataStructure::Heap.new()
		(array_length).downto(0).each do |element|
			heap.include(array[element])
		end
		
		arrayAux = Array.new
		heap.build_max_heap
		
		(array_length).downto(1) do |number|
			arrayAux.insert(0,heap.heap[0])
			aux = heap.heap[0]
			heap.heap[0] = heap.heap[number]
			heap.heap[number] = aux
			heap.remove(number)
			heap.max_heapify(0)
		end
		
		arrayAux.insert(0,heap.heap[0])
		
		for i in 0..array_length
			array[i] = arrayAux[i]
		end		
	end
	
	def Sort.quick_sort(array, random_partition = false)
		Sort.quick_sort_solver(array,0,array.length-1, random_partition)
	end
	
	#assumes that all elements in array are >=0
	def Sort.counting_sort(array)
		array.each do |number|
			if number.class != Fixnum
				raise "all elements must be a number"
			else
				if number < 0
					raise "all numbers must be non-negatives"
				end
			end
		end
		sorted_array = Array.new
		array_temp = Array.new
		max_value = -1
		for i in 0...array.length do
			if max_value < array[i]
				max_value = array[i]
			end
		end

		for i in 0..max_value 
			array_temp[i] = 0
		end
		
		for i in 0...array.length
			array_temp[array[i]] = array_temp[array[i]] + 1 
		end
		
		for i in 1...array_temp.length
			array_temp[i] = array_temp[i] + array_temp[i-1]
		end

		(array.length-1).downto(0) do |number|
			if array_temp[array[number]] > 0
				sorted_array[array_temp[array[number]]-1] = array[number]
				array_temp[array[number]] = array_temp[array[number]] - 1
			end
		end
		
		for i in 0...array.length
			array[i] = sorted_array[i]
		end
	end
	
	#Not Working
	#assumes that all elements in array was 0<=i<1
	def Sort.bucket_sort(array)
		array.each do |number|
			if number < 0 || number > 1
				raise "You can only pass numbers between [0,1)"
			end
		end
		
		bucket = Array.new(array.length)
		
		for i in 0...bucket.length
			bucket[i] = DataStructure::DoubleUnsortedLinkedList.new
		end
		
		for i in 0...array.length
			bucket[((i*array[i])/1)]
		end
	end
	
	private 
		def Sort.quick_sort_solver(array,start,finish,randomized_partition = false)
			if start < finish
				if randomized_partition
					random = rand(array.length)
					aux = array[finish]
					array[finish] = array[random]
					array[random] = aux
				end
				pivot = partition(array,start,finish)
				Sort.quick_sort_solver(array,start,pivot-1)
				Sort.quick_sort_solver(array,pivot+1,finish)
			end
		end
		
		def Sort.partition(array,start,finish) 
			pivot = array[finish]
			i = start - 1
			for j in start...finish do
				if array[j] <= pivot
					i=i+1
					aux = array[i]
					array[i] = array[j]
					array[j] = aux
				end
			end
			aux = array[i+1]
			array[i+1] = array[finish]
			array[finish] = aux
			return i+1
		end

end