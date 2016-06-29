class TargetsController < ApplicationController
  before_action :set_target, only: [:show, :edit, :update, :destroy]
  PER_PAGE= 20
  # GET /targets
  # GET /targets.json
  def index
    @targets = Target.targets(current_user,params).order('id desc').paginate(:per_page => PER_PAGE,:page => (params[:page] || 1))
  end

  # GET /targets/1
  # GET /targets/1.json
  def show
  end

  # GET /targets/new
  def new
    @target = Target.new
  end

  # GET /targets/1/edit
  def edit
  end

  # POST /targets
  # POST /targets.json
  def create
    @target = Target.new(target_params.
                          merge(user_id: user.id).
                          merge(location_code: user.location_code))

    respond_to do |format|
      if @target.save
        format.html { redirect_to @target, notice: 'Target was successfully created.' }
        format.json { render :show, status: :created, location: @target }
      else
        format.html { render :new }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

   

   

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_target
      @target = Target.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def target_params
      params.require(:target).permit(:mum,:rds,:date,:fos,:value_target,:volume_target,:plan_remarks,:location_code,:review_remarks,:imei,:user_id,focus_models_attributes: [:target_model_name,:sale])
    end

    def user

      User.find_by(remember_token: params[:remember_token])
    end 
 

    
end
