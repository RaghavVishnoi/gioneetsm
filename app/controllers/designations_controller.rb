class DesignationsController < ApplicationController
  before_action :set_designation, only: [:show, :edit, :update, :destroy]

  # GET /designations
  # GET /designations.json
  def index
    @designations = Designation.all
  end

  # GET /designations/1
  # GET /designations/1.json
  def show
  end

  # GET /designations/new
  def new
    @designation = Designation.new
  end

  # GET /designations/1/edit
  def edit
  end

  # POST /designations
  # POST /designations.json
  def create
    @designation = Designation.new(designation_params)

    respond_to do |format|
      if @designation.save
        format.html { redirect_to @designation, notice: 'Designation was successfully created.' }
        format.json { render :show, status: :created, location: @designation }
      else
        format.html { render :new }
        format.json { render json: @designation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /designations/1
  # PATCH/PUT /designations/1.json
  def update
    respond_to do |format|
      if @designation.update(designation_params)
        format.html { redirect_to @designation, notice: 'Designation was successfully updated.' }
        format.json { render :show, status: :ok, location: @designation }
      else
        format.html { render :edit }
        format.json { render json: @designation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /designations/1
  # DELETE /designations/1.json
  def destroy
    @designation.destroy
    respond_to do |format|
      format.html { redirect_to designations_url, notice: 'Designation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_designation
      @designation = Designation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def designation_params
      params.fetch(:designation, {})
    end
end
