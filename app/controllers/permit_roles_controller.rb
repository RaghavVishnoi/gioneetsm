class PermitRolesController < ApplicationController
  before_action :set_permit_role, only: [:show, :edit, :update, :destroy]

  # GET /permit_roles
  # GET /permit_roles.json
  def index
    @permit_roles = PermitRole.all
  end

  # GET /permit_roles/1
  # GET /permit_roles/1.json
  def show
  end

  # GET /permit_roles/new
  def new
    @permit_role = PermitRole.new
  end

  # GET /permit_roles/1/edit
  def edit
  end

  # POST /permit_roles
  # POST /permit_roles.json
  def create
    @permit_role = PermitRole.new(permit_role_params)
    if @permit_role.save
      redirect_to permit_roles_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /permit_roles/1
  # PATCH/PUT /permit_roles/1.json
  def update
    respond_to do |format|
      if @permit_role.update(permit_role_params)
        format.html { redirect_to @permit_role, notice: 'Permit role was successfully updated.' }
        format.json { render :show, status: :ok, location: @permit_role }
      else
        format.html { render :edit }
        format.json { render json: @permit_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permit_roles/1
  # DELETE /permit_roles/1.json
  def destroy
    @permit_role.destroy
    respond_to do |format|
      format.html { redirect_to permit_roles_url, notice: 'Permit role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permit_role
      @permit_role = PermitRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permit_role_params
      params.require(:permit_role).permit(:parent_role, :child_role)
    end
end
