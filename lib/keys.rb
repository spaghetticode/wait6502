class Keys
  def self.keys
    @keys = []
    row(%w[q w e r t y u i o p], 26, 21)
    row(%w[a s d f g h j k l], 26, 48)
    row(%w[z x c v b n m], 26, 75)
    row(%w[7 8 9], 303, 21)
    row(%w[4 5 6], 303, 48)
    row(%w[1 2 3], 303, 75)
    row(%w[0], 303, 102)
    @keys
  end
  
  def self.row(letters, start, fixed)
    letters.inject(start) do |pos, key|
      opacity = 'background:maroon;opacity:0.1' if Letter.find_by_name(key).hardware.size.zero?
      @keys << {:letter => key, :style => "top:#{fixed}px;left:#{pos}px;#{opacity}"}
      pos + 27
    end
  end
end