module ControllerMacros
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def should_flash_and_redirect_for(actions, options={})
      actions.each do |action, method|
        it "should flash and redirect on #{method.to_s.upcase} #{action.to_s.upcase}" do
          send(method, action, options.merge(:id => '1'))
          response.should be_redirect
          flash[:notice].should == 'You must be logged in to access this page'
        end
      end
    end
  end
end