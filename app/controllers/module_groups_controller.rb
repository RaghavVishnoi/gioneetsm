class ModuleGroupsController < ApplicationController
  before_action :set_module_group, only: [:show, :edit, :update, :destroy]

  # GET /module_groups
  # GET /module_groups.json
  def index
    @module_groups = ModuleGroup.all
  end

  # GET /module_groups/1
  # GET /module_groups/1.json
  def show
  end

  # GET /module_groups/new
  def new
    @module_group = ModuleGroup.new
  end

  # GET /module_groups/1/edit
  def edit
  end

  # POST /module_groups
  # POST /module_groups.json
  def create
    @module_group = ModuleGroup.new(module_group_params)

      if @module_group.save
        redirect_to module_groups_path
      else
       render :new 
      end
   
  end

  # PATCH/PUT /module_groups/1
  # PATCH/PUT /module_groups/1.json
  def update
    respond_to do |format|
      if @module_group.update(module_group_params)
        format.html { redirect_to module_groups_path, notice: 'Module group was successfully updated.' }
        format.json { render :show, status: :ok, location: @module_group }
      else
        format.html { render :edit }
        format.json { render json: @module_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /module_groups/1
  # DELETE /module_groups/1.json
  def destroy
    @module_group.destroy
    respond_to do |format|
      format.html { redirect_to module_groups_url, notice: 'Module group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_module_group
      @module_group = ModuleGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def module_group_params
      params.require(:module_group).permit(:name)
    end
end
