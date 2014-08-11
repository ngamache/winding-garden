class StonesController < ApplicationController
  # GET /stones
  # GET /stones.json
  def index
    @stones = Stone.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stones }
    end
  end

  # GET /stones/1
  # GET /stones/1.json
  def show
    @stone = Stone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stone }
    end
  end

  # GET /stones/new
  # GET /stones/new.json
  def new
    @stone = Stone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stone }
    end
  end

  # GET /stones/1/edit
  def edit
    @stone = Stone.find(params[:id])
  end

  # POST /stones
  # POST /stones.json
  def create
    @stone = Stone.new(params[:stone])

    respond_to do |format|
      if @stone.save
        format.html { redirect_to @stone, notice: 'Stone was successfully created.' }
        format.json { render json: @stone, status: :created, location: @stone }
      else
        format.html { render action: "new" }
        format.json { render json: @stone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stones/1
  # PUT /stones/1.json
  def update
    @stone = Stone.find(params[:id])

    respond_to do |format|
      if @stone.update_attributes(params[:stone])
        format.html { redirect_to @stone, notice: 'Stone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stones/1
  # DELETE /stones/1.json
  def destroy
    @stone = Stone.find(params[:id])
    @stone.destroy

    respond_to do |format|
      format.html { redirect_to stones_url }
      format.json { head :no_content }
    end
  end
end
