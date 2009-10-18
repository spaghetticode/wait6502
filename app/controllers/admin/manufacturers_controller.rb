class Admin::ManufacturersController < ApplicationController
  # GET /admin_manufacturers
  # GET /admin_manufacturers.xml
  def index
    @manufacturers = Manufacturer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_manufacturers }
    end
  end

  # GET /admin_manufacturers/1
  # GET /admin_manufacturers/1.xml
  def show
    @manufacturer = Manufacturer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @manufacturer }
    end
  end

  # GET /admin_manufacturers/new
  # GET /admin_manufacturers/new.xml
  def new
    @manufacturer = Manufacturer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @manufacturer }
    end
  end

  # GET /admin_manufacturers/1/edit
  def edit
    @manufacturer = Manufacturer.find(params[:id])
  end

  # POST /admin_manufacturers
  # POST /admin_manufacturers.xml
  def create
    @manufacturer = Manufacturer.new(params[:manufacturer])

    respond_to do |format|
      if @manufacturer.save
        flash[:notice] = 'Manufacturer was successfully created.'
        format.html { redirect_to(@manufacturer) }
        format.xml  { render :xml => @manufacturer, :status => :created, :location => @manufacturer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @manufacturer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_manufacturers/1
  # PUT /admin_manufacturers/1.xml
  def update
    @manufacturer = Manufacturer.find(params[:id])

    respond_to do |format|
      if @manufacturer.update_attributes(params[:manufacturer])
        flash[:notice] = 'Manufacturer was successfully updated.'
        format.html { redirect_to(@manufacturer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @manufacturer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_manufacturers/1
  # DELETE /admin_manufacturers/1.xml
  def destroy
    @manufacturer = Manufacturer.find(params[:id])
    @manufacturer.destroy

    respond_to do |format|
      format.html { redirect_to(admin_manufacturers_url) }
      format.xml  { head :ok }
    end
  end
end
