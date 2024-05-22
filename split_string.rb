def solution(str)
  pairs = []
  i = 0
  while i < str.length
    if i + 1 < str.length
      pairs << str[i] + str[i + 1]
    else
      pairs << str[i] + '_'
    end
    i += 2
  end
  pairs
end
