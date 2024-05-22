def moveZeros(arr)
  non_zeros, zeros = arr.partition { |x| x != 0 }
  non_zeros + zeros
end
