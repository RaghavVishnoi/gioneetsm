class RetailersController < ApplicationController
  
  before_action :set_retailer, only: [:show, :edit, :update, :destroy]
   

  PER_PAGE = 20
  # GET /retailers
  # GET /retailers.json
  def index
     @retailers = Retailer.retailers(current_user,params).order('updated_at desc').paginate(:per_page => PER_PAGE,:page => (params[:page] || 1))
   end

  # GET /retailers/1
  # GET /retailers/1.json
  def show
  end

  # GET /retailers/new
  def new
    @retailer = Retailer.new
  end

  # GET /retailers/1/edit
  def edit
  end

  # POST /retailers
  # POST /retailers.json
  def create
    @retailer = Retailer.new(retailer_params.merge(user_id: user.id))

    respond_to do |format|
      if is_exists?(@retailer.retailer_code) && @retailer.retailer_code != nil && @retailer.retailer_code != ''
        retailers = Retailer.where('retailer_code = ? OR tmpCode = ?',@retailer.retailer_code,@retailer.retailer_code)
        if retailers.length > 1
          retailer = retailers.destroy_all(['id NOT IN (?)', retailers.last(1).collect(&:id)]).first
          retailers.last.competition_details.destroy_all
          retailers.last.update(retailer_params)
        else
          retailers.first.competition_details.destroy_all
          retailers.first.update_attributes(retailer_params)
        end
        if params[:is_new] == 1
            tmpCount = Retailer.where('length(tmpCount) != 0').order('updated_at asc').last
            tmpData = Constant.tempCode(tmpCount)
            Retailer.where(retailer_code: @retailer.retailer_code).update_all(tmpCode: tmpData[:tmpCode],tmpCount: tmpData[:tmpCount],retailer_code: @retailer.retailer_code)  
        end
          format.html { redirect_to @retailer, notice: 'Retailer was successfully created.' }
          format.json { render :show, status: :created, location: @retailer }
      else
        if @retailer.save!
          if params[:is_new] == 1
            tmpCount = Retailer.where('length(tmpCount) != 0').order('updated_at asc').last
            tmpData = Constant.tempCode(tmpCount)
            @retailer.update(tmpCode: tmpData[:tmpCode],tmpCount: tmpData[:tmpCount],retailer_code: '')  
          end
          format.html { redirect_to @retailer, notice: 'Retailer was successfully created.' }
          format.json { render :show, status: :created, location: @retailer }
        else
          format.html { render :new }
          format.json { render json: @retailer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /retailers/1
  # PATCH/PUT /retailers/1.json
  # def update
  #   respond_to do |format|
  #     if @retailer.update(retailer_params)
  #       format.html { redirect_to @retailer, notice: 'Retailer was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @retailer }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @retailer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /retailers/1
  # DELETE /retailers/1.json
  # def destroy
  #   @retailer.destroy
  #   respond_to do |format|
  #     format.html { redirect_to retailers_url, notice: 'Retailer was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def is_visited
    if Retailer.where('upper(mum) = ? AND upper(retailer_code) = ?',params[:mum].upcase,params[:retailer_code].upcase).length != 0
      retailer = Retailer.where(mum: params[:mum],retailer_code: params[:retailer_code]).last
      render :json => {result: true,message: "#{params[:mum]} have visited this shop on #{retailer.updated_at.strftime("%d %b,%Y")}"}
    else
      render :json => {result: false,status: INVALID_CREDENTAILS_STATUS,message: "This shop was not visited by #{params[:mum]}!"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retailer
      @retailer = Retailer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def retailer_params
      params.require(:retailer).permit(:retailer_name,:retailer_code,:retailer_phone,:mum,:state,:city,:address,:landmark,:store_area,:store_monthly_sales_volume,:store_monthly_sales_value,:location_code,:imei ,competition_details_attributes: [:brand_name,:sale,:volume,:promoters,:is_sis,:is_gsb,:retailer_id], location_attributes: [:lat,:lng,:location,:retailer_id])
    end

    def user
      User.find_by(remember_token: params[:remember_token])
    end

    def is_exists?(retailer_code)
      Retailer.exists?(['retailer_code = ? OR tmpCode = ?',retailer_code,retailer_code])
    end
end
