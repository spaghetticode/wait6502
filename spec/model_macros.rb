share_as :NaturalKeyTable do
  describe 'a new blank instance' do
     it 'should not be valid' do
       @class.new.should_not be_valid
     end

     it 'should require name' do
       @class.new.should have(1).error_on(:name)
     end

     it 'should require a unique name' do
       valid = Factory(@class.class_name.underscore)
       invalid = @class.new(:name => valid.name)
       invalid.should have(1).error_on(:name)
     end
   end

  describe 'an instance with valid attributes' do
    before do
      @valid = Factory(@class.class_name.underscore)
    end
    
    it 'should be valid' do
      @valid.should be_valid
    end

    it 'should have id same as name (name is primary key)' do
      @valid.id.should == @valid.name
    end
  end

  describe 'named scope ORDERED' do
     before do
       5.times {Factory(@class.class_name.underscore)}
     end

     it 'should sort co cpu types by name' do
       @class.ordered.should == @class.all.sort_by(&:name)
     end
   end
end

share_as :NameUniqueRequired do
  it 'should not be valid' do
    @class.new.should_not be_valid
  end
  
  it 'should require name' do
    @class.new.should have(1).error_on(:name)
  end
  
  it 'should require a unique name' do
    valid = Factory(@class.class_name.underscore)
    invalid = @class.new(:name => valid.name)
    invalid.should have(1).error_on(:name)
  end
end