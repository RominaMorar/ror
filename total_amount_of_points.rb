def points(games)
  
  if games.length != 10
    raise ArgumentError, "Invalid input: Expected 10 match results, got #{games.length}"
  end

  total_points = 0
  games.each do |match|
    scores = match.split(":").map(&:to_i)
    our_score, opponent_score = scores

    total_points += case
                    when our_score > opponent_score then 3
                    when our_score < opponent_score then 0
                    else 1
                    end
  end

  total_points
end
