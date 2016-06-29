class SalesBeatsController < ApplicationController
  before_action :set_sales_beat, only: [:show, :edit, :update, :destroy]
  PER_PAGE = 20
  # GET /sales_beats
  # GET /sales_beats.json
  def index
    @sales_beats = SalesBeat.sales_beats(current_user,params).order('id desc').paginate(:per_page => PER_PAGE,:page => (params[:page] || 1))
  end

  # GET /sales_beats/1
  # GET /sales_beats/1.json
  def show
  end

  # GET /sales_beats/new
  def new
    @sales_beat = SalesBeat.new
  end

  # GET /sales_beats/1/edit
  def edit
  end

  # POST /sales_beats
  # POST /sales_beats.json
  def create
    @sales_beat = Parse.sales_beat(params,user.id)
    if @sales_beat
      render :json => {result: true}
    else
      render :json => {result: false,status: INVALID_CREDENTAILS_STATUS}
    end
  end

  # PATCH/PUT /sales_beats/1
  # PATCH/PUT /sales_beats/1.json
  # def update
  #   respond_to do |format|
  #     if @sales_beat.update(sales_beat_params)
  #       format.html { redirect_to @sales_beat, notice: 'Sales beat was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @sales_beat }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @sales_beat.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /sales_beats/1
  # DELETE /sales_beats/1.json
  # def destroy
  #   @sales_beat.destroy
  #   respond_to do |format|
  #     format.html { redirect_to sales_beats_url, notice: 'Sales beat was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_beat
      @sales_beat = SalesBeat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_beat_params
      params.require(:sales_beat).permit(:mum,:rds,:date,:retailer_code,:stock_count,:is_sis_maintained,:is_gsb_maintained,:gcs_present,:imei,:location_code,location_attributes: [:lat,:lng,:location],stocks_attributes: [:mod_name,:count])
    end

    def user
      User.find_by(remember_token: params[:remember_token])
    end
end
