class Admin::ComputerTypesController < ApplicationController
  before_filter :require_logged_in
  layout 'admin'
  # GET /admin_computer_types
  # GET /admin_computer_types.xml
  def index
    @computer_types = ComputerType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_computer_types }
    end
  end

  # GET /admin_computer_types/1
  # GET /admin_computer_types/1.xml
  def show
    @computer_type = ComputerType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @computer_type }
    end
  end

  # GET /admin_computer_types/new
  # GET /admin_computer_types/new.xml
  def new
    @computer_type = ComputerType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @computer_type }
    end
  end

  # GET /admin_computer_types/1/edit
  def edit
    @computer_type = ComputerType.find(params[:id])
  end

  # POST /admin_computer_types
  # POST /admin_computer_types.xml
  def create
    @computer_type = ComputerType.new(params[:computer_type])

    respond_to do |format|
      if @computer_type.save
        flash[:notice] = 'Computer type was successfully created.'
        format.html { redirect_to computer_types_path }
        format.xml  { render :xml => @computer_type, :status => :created, :location => @computer_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @computer_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_computer_types/1
  # PUT /admin_computer_types/1.xml
  def update
    @computer_type = ComputerType.find(params[:id])

    respond_to do |format|
      if @computer_type.update_attributes(params[:computer_type])
        flash[:notice] = 'Computer type was successfully updated.'
        format.html { redirect_to computer_types_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @computer_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_computer_types/1
  # DELETE /admin_computer_types/1.xml
  def destroy
    ComputerType.find(params[:id]).destroy
    flash[:notice] = 'Computer type was successfully destroyed.'
    redirect_to computer_types_path
  end
end
