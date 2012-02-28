module Problems
	module DivideAndConquer
		
		#This problem take as an input an array and finds continuous subarray which has the highest sum, it will return this maximum subarray
		#According to Cormen, this algorithm runs in a complexity of nlogn = Asymptotically
		def self.maximum_subarray(array)
			if array.length > 1
				hash_result = Hash.new
				hash_result = search_maximum_subarray(array,0,array.length-1,hash_result)
				result = Array.new
				for i in hash_result[:low]..hash_result[:high]
					result << array[i]
				end
				return result
			else
				return array
			end
		end
		
		
		private
			FIXNUM_MAX = (2**(0.size * 8 -2) -1)
			FIXNUM_MIN = -(2**(0.size * 8 -2))
			def self.search_maximum_subarray(array,low, high,result)
				
				if low >= high
					result[:low] = low
					result[:high] = high
					result[:sum] = array[low]
					return result
				else
					mid = (low+high)/2

					returned_hash = search_maximum_subarray(array,low,mid,result)
					result[:left_low] = returned_hash[:low]
					result[:left_high] = returned_hash[:high]
					result[:left_sum] = returned_hash[:sum]
					
					returned_hash = search_maximum_subarray(array,mid+1,high,result)
					result[:rigth_low] = returned_hash[:low]
					result[:rigth_high] = returned_hash[:high]
					result[:rigth_sum] = returned_hash[:sum]
					
					
					returned_hash = find_max_crossing_subarray(array,low,mid,high)
					result[:cross_low] = returned_hash[:max_left]
					result[:cross_high] = returned_hash[:max_rigth]
					result[:cross_sum] = returned_hash[:sum]
					
					if result[:left_sum] >= result[:rigth_sum] && result[:left_sum] >= result[:cross_sum] 
						result[:low] = result[:left_low]
						result[:high] = result[:left_high]
						result[:sum] = result[:left_sum]
					elsif result[:rigth_sum] >= result[:left_sum] && result[:rigth_sum] >= result[:cross_sum] 
							result[:low] = result[:rigth_low]
							result[:high] = result[:rigth_high]
							result[:sum] = result[:rigth_sum]
					else
						result[:low] = result[:cross_low]
						result[:high] = result[:cross_high]
						result[:sum] = result[:cross_sum]
					end
					return result
				end
			end
		
			def self.find_max_crossing_subarray(array,low,mid,high)
				left_sum = FIXNUM_MIN
				sum = 0
				result = Hash.new
				
				mid.downto(low) do |number|
					sum = sum + array[number]
					if sum > left_sum
						left_sum = sum
						result[:max_left] = number
					end
				end

				rigth_sum = FIXNUM_MIN
				sum = 0
				
				for j in mid+1..high
					sum = sum + array[j]
					if sum > rigth_sum
						rigth_sum = sum
						result[:max_rigth] = j
					end
				end
				result[:sum] = left_sum + rigth_sum
				return result
			end
	end
end

