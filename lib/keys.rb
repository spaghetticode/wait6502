class Keys
  def self.letters
    letters = []
    %w{q w e r t y u i o p }.inject(0) do |i,letter|
      letters << [letter, "#{21+i},21, #{48+i},48"]
      i += 27
    end
    %w{a s d f g h j k l}.inject(0) do |i, letter|
      letters << [letter, "#{21+i},49, #{48+i},75"]
      i += 27
    end
    %w{z x c v b n m}.inject(0) do |i, letter|
      letters << [letter, "#{21+i},76, #{48+i},102"]
      i += 27
    end
    %w{7 8 9}.inject(0) do |i, letter|
      letters << [letter, "#{299+i},21, #{326+i},48"]
      i += 27
    end
    %w{4 5 6}.inject(0) do |i, letter|
      letters << [letter, "#{299+i},49, #{326+i},75"]
      i += 27
    end
    %w{1 2 3}.inject(0) do |i, letter|
      letters << [letter, "#{299+i},76, #{326+i},102"]
      i += 27
    end
    letters << ['0', "299,102, 326,129"]
    letters    
  end
end