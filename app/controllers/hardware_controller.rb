class HardwareController < ApplicationController
  layout 'museum'
  
  def index
    unless @letter = Letter.find_by_name(params[:letter])
      flash[:error] = 'You must choose a letter'
      redirect_to root_path
    else
      @computers = @letter.hardware.computer.by_manufacturer
      @peripherals = @letter.hardware.peripheral.by_manufacturer
      session[:return_to] = {
        :name => "#{@letter.name} hardware",
        :url => request.request_uri
      } 
    end
  end

  def show
    @hardware = Hardware.find(params[:id])
    validate_permalink(@hardware, :hardware_path)
  end
end
