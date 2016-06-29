class UserParentsController < ApplicationController
  before_action :set_user_parent, only: [:show, :edit, :update, :destroy]

  # GET /user_parents
  # GET /user_parents.json
  def index
    @user_parents = UserParent.all
  end

  # GET /user_parents/1
  # GET /user_parents/1.json
  def show
  end

  # GET /user_parents/new
  def new
    @user_parent = UserParent.new
  end

  # GET /user_parents/1/edit
  def edit
  end

  # POST /user_parents
  # POST /user_parents.json
  def create
    @user_parent = UserParent.new(user_parent_params)

    respond_to do |format|
      if @user_parent.save
        format.html { redirect_to user_parents_path, notice: 'User parent was successfully created.' }
        format.json { render :index, status: :created, location: @user_parent }
      else
        format.html { render :new }
        format.json { render json: @user_parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_parents/1
  # PATCH/PUT /user_parents/1.json
  def update
    respond_to do |format|
      if @user_parent.update(user_parent_params)
        format.html { redirect_to user_parents_path, notice: 'User parent was successfully updated.' }
        format.json { render :index, status: :ok, location: @user_parent }
      else
        format.html { render :edit }
        format.json { render json: @user_parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_parents/1
  # DELETE /user_parents/1.json
  def destroy
    @user_parent.destroy
    respond_to do |format|
      format.html { redirect_to user_parents_url, notice: 'User parent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_parent
      @user_parent = UserParent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_parent_params
      params.require(:user_parent).permit(:parent_id,:child_id)
    end
end
