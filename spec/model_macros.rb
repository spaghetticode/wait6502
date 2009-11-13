share_as :NaturalKeyTable do
  describe 'a new blank instance' do
     it 'should not be valid' do
       @class.new.should_not be_valid
     end

     it 'should require name' do
       @class.new.should have(1).error_on(:name)
     end

     it 'should require a unique name' do
       co_cpu_type = Factory(@class.class_name.underscore)
       invalid = @class.new(:name => co_cpu_type.name)
       invalid.should have(1).error_on(:name)
     end
   end

  describe 'an instance with valid attributes' do
     it 'should be valid' do
       @class.new(:name => 'name').should be_valid
     end

     it 'should have id same as name (name is primary key)' do
       co_cpu_type = Factory(@class.class_name.underscore)
       co_cpu_type.id.should == co_cpu_type.name
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
    StorageFormat.new.should_not be_valid
  end
  
  it 'should require name' do
    StorageFormat.new.should have(1).error_on(:name)
  end
  
  it 'should require a unique name' do
    storage_format = Factory(:storage_format)
    invalid = StorageFormat.new(:name => storage_format.name)
    invalid.should have(1).error_on(:name)
  end
end