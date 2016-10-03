module MarchMadness
  # Declare the possible matches for each round within a given bracket region
  SEEDS = {
    32 => { # seeds for a 32 competitors tournament
      1 => [[1, 8], [4, 5], [3, 6], [2, 7]],
      2 => [[1, 8, 4, 5], [3, 6, 2, 7]],
      3 => [[1, 8, 4, 5, 3, 6, 2, 7]]
    },
    64 => { # seeds for a 64 competitors tournament
      1 => [[1, 16], [8, 9], [5, 12], [4, 13], [6, 11], [3, 14], [7, 10], [2, 15]],
      2 => [[1, 16, 8, 9], [5, 12, 4, 13], [6, 11, 3, 14], [7, 10, 2, 15]],
      3 => [[1, 16, 8, 9, 5, 12, 4, 13], [6, 11, 3, 14, 7, 10, 2, 15]],
      4 => [[1, 16, 8, 9, 5, 12, 4, 13, 6, 11, 3, 14, 7, 10, 2, 15]]
    }
  }
end
