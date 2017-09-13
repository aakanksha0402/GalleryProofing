class ReferFriendsController < ApplicationController
  before_filter :authenticate_user!
  def refer
  end

  def send_email
    @mails = params[:mail_id]
    @body = params[:body]

    @mails.split(',').each do |email|
      @refer = ReferFriend.create!(email_address: email, email_body: @body, brand_id: current_brand.id)
      ReferMailer.refer_a_friend(@refer, current_brand.brand_name).deliver_later
    end
    respond_to do |format|
      format.js
    end
  end
end
