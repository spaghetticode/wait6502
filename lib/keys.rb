class Keys
  def self.keys
    keys = []
    %w[q w e r t y u i o p].inject(26) do |pos, key|
      keys << {:letter => key, :position => "top:21px;left:#{pos}px;"}
      pos += 27
    end
    %w[a s d f g h j k l].inject(26) do |pos, key|
      keys << {:letter => key, :position => "top:48px;left:#{pos}px"}
      pos += 27
    end
    %w[z x c v b n m].inject(26) do |pos, key|
      keys << {:letter => key, :position => "top:75px;left:#{pos}px"}
      pos += 27
    end
    %w[7 4 1 0].inject(21) do |pos,key|
      keys << {:letter => key, :position => "top:#{pos}px;left:303px"}
      pos += 27
    end
    %w[8 5 2].inject(21) do |pos,key|
      keys << {:letter => key, :position => "top:#{pos}px;left:330px"}
      pos += 27
    end
    %w[9 6 3].inject(21) do |pos,key|
      keys << {:letter => key, :position => "top:#{pos}px;left:358px"}
      pos += 27
    end
    keys
  end
end