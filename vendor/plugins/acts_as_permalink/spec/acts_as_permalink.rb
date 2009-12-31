require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

Spec::Runner.configure do |config|
  config.fixture_path = File.dirname(__FILE__) + '/fixtures'
end

describe ActsAs::Permalink do
  before :all do
    ActiveRecord::Base.establish_connection({
      :adapter => 'sqlite3',
      :database => 'spec.db'
    })

    ActiveRecord::Schema.define do
      create_table :friends, :force => true do |t|
        t.string :name
        t.string :surname
      end
    end
    
    class Friend < ActiveRecord::Base
      acts_as_permalink :full_name
      def full_name
        "#{name} #{surname}"
      end
    end
  end
  
  after :all do
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end
  
  describe 'acts_as_permalink' do
    it 'ActiveRecord::Base should include acts_as_permalink method' do
      ActiveRecord::Base.methods.should include('acts_as_permalink')
    end
  end
  
  describe 'permalink' do
    fixtures :friends
    
    it 'should load fixtures' do
      friends('andrea').should_not be_nil
    end
  
    it 'should downcase strings' do
      friends(:andrea).to_param.should == '1-andrea-longhi'
    end
  
    it 'should replace accented vowels' do
      friends(:andre).to_param.should == '2-andre-longhi'
    end
  
    describe 'testing special cases' do
      before do
        @friend = Friend.first
      end
  
      it 'should remove multiple dashes' do
        @friend.name = 'Andrea--Piero'
        @friend.to_param.should == '1-andrea-piero-longhi'
      end
  
      it 'should replace punctation' do

        @friend.name = 'F.B.I'
        @friend.to_param.should == '1-f-b-i-longhi'
      end
  
      it 'should remove dashes from ends' do
        @friend.name = '---Andrea----'
        @friend.to_param.should == '1-andrea-longhi'
      end
  
      it 'should remove currency symbols' do
        @friend.name = 'Andrea$€£'
        @friend.to_param.should == '1-andrea-longhi'
      end
  
      it 'should remove end punctation' do
        @friend.name = 'Andrea,:;.'
        @friend.to_param.should == '1-andrea-longhi'
      end
  
      it 'should remove reserved chars' do
        @friend.name = 'Andrea(?!?!)'
        @friend.to_param.should == '1-andrea-longhi'
      end
    end
  end
end