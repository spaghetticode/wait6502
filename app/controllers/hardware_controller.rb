class HardwareController < ApplicationController
  layout 'museum'
  
  def index
    @letter = Letter.find_by_name(params[:letter])
    flash.now[:error] = 'You must choose a letter' unless @letter
    @computers = @letter.hardware.computer.by_manufacturer
    @peripherals = @letter.hardware.peripheral.by_manufacturer
    session[:return_to] = {
      :name => "#{@letter.name} hardware",
      :url => request.request_uri
    } 
  end

  def show
    @hardware = Hardware.find(params[:id])
    validate_permalink(@hardware, :hardware_path)
  end
end
