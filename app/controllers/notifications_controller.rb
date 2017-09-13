class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy, :dismiss_notification]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.where(:brand_id => current_brand.id,:is_dismiss => false)
    @today_notifications = Notification.where("created_at = ? AND is_dismiss = ? AND brand_id =?", Time.zone.now.beginning_of_day,false,current_brand.id)
    @yesterday_notifications = Notification.where("DATE(created_at) = ? AND is_dismiss = ? AND brand_id =?", Date.today-1,false,current_brand.id)
    @rest_notifications = @notifications - @yesterday_notifications - @today_notifications
    @notifications_dismiss = Notification.where(:brand_id => current_brand.id,:is_dismiss => true)
    @today_notifications_dismiss = Notification.where("created_at = ? AND is_dismiss = ? AND brand_id =?", Time.zone.now.beginning_of_day,true,current_brand.id)
    @yesterday_notifications_dismiss = Notification.where("DATE(created_at) = ? AND is_dismiss = ? AND brand_id =?", Date.today-1,true,current_brand.id)
    @rest_notifications_dismiss = @notifications_dismiss - @yesterday_notifications_dismiss - @today_notifications_dismiss
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end
  def update_dismiss
    if params[:update_all].present?
      dismiss = Notification.where(:brand_id => current_brand)
      respond_to do |format|
        if dismiss.update_all(:is_dismiss => true)
          format.html { redirect_to notifications_path, notice: 'Notification was successfully updated.' }

        end
      end
    elsif params[:id].present?
      dismiss = Notification.find(params[:id])
      respond_to do |format|
        if dismiss.update_attributes(:is_dismiss => true)
          format.html { redirect_to notifications_path, notice: 'Notification was successfully updated.' }

        end
      end
    else
       respond_to do |format|
        if dismiss.update_attributes(:is_dismiss => true)
          format.html { redirect_to notifications_path, notice: 'Notification was successfully updated.' }

        end
      end
    end
  end
  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def dismiss_notification
    @notification.update_attributes(is_dismiss: true)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:notification_from, :id_from, :brand_id, :is_dismiss)
    end
end
