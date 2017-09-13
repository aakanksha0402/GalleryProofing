class UserPermissionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :deactivate_user, :activate_user]


  def index
    if @current_user_permissions.find_by(permission_name: "View Administration").value == false
      @not_authorized = true
    end
    @main_users = User.where(id: current_user.id)
    @sub_users = User.where(studio_id: current_user.id)
    @users = @main_users | @sub_users
  end

  def create
    @user = User.new(user_params)
    @permission_action = PermissionAction.all
    @permission_section = PermissionSection.all
    @ps = Section.all
    respond_to do |format|
      if @user.save
        @var = PermissionActionPermissionSection.all
        @var.each do |var|
          if params[:values].present?
            if params[:values].include? var.id.to_s
              @per = Permission.new(permission_action_permission_section_id: var.id, value: true, user_id: @user.id, permission_name: var.name)
            else
              @per = Permission.new(permission_action_permission_section_id: var.id, value: false, user_id: @user.id, permission_name: var.name)
            end
          else
            @per = Permission.new(permission_action_permission_section_id: var.id, value: false, user_id: @user.id, permission_name: var.name)
          end
          @per.save!
        end

        format.html { redirect_to user_permissions_path }
        format.json { render :index, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    $fullname = @user.firstname + " " + @user.lastname
    @email = session[:user]["email"]
    @permissions = Permission.where(user_id: @user.id)
    @permission_action = PermissionAction.all
    @permission_section = PermissionSection.all
    @paps = PermissionActionPermissionSection.all
  end

  def update
    if @current_user_permissions.find_by(permission_name: "Edit Administration").value == false
      @not_authorized = true
      render (:edit)
    else
      puts "yo"
        @permissions = Permission.where(user_id: @user.id)
        @permission_action = PermissionAction.all
        @permission_section = PermissionSection.all
        @paps = PermissionActionPermissionSection.all
        if params[:user][:password].present?
          @user.update(email: params[:user][:email], firstname: params[:user][:firstname], lastname: params[:user][:lastname], password: params[:user][:password])
          sign_in(:user, current_user, :bypass => true)
          @permission = Permission.where(user_id: @user.id)
          if @user.studio_id.present?
            if params[:values].present?
              @permission.each do |permission|
                if params[:values].include? permission.permission_action_permission_section_id.to_s
                  @per = Permission.where(permission_action_permission_section_id: params[:values], user_id: @user.id).update_all(value: true)
                else
                  @per = Permission.where(permission_action_permission_section_id: permission.permission_action_permission_section_id, user_id: @user.id).update_all(value: false)
                end
              end
            else
              unless @user.id == session[:user].id
                unless params[:user][:a].present?
                  @per = @permission.update_all(value: false)
                end
              end
            end
          end
          redirect_to user_permissions_path
          session.delete(:modal)
        else
         respond_to do |format|
           if @user.update_without_password(firstname: params[:user][:firstname], lastname: params[:user][:lastname], email: params[:user][:email] )
             session.delete(:modal)
             @per = true
             @permission = Permission.where(user_id: @user.id)
             if @user.studio_id.present?
               if params[:values].present?
                 @permission.each do |permission|
                   if params[:values].include? permission.permission_action_permission_section_id.to_s
                     @per = Permission.where(permission_action_permission_section_id: params[:values], user_id: @user.id).update_all(value: true)
                   else
                     @per = Permission.where(permission_action_permission_section_id: permission.permission_action_permission_section_id, user_id: @user.id).update_all(value: false)
                   end
                 end
               else
                 unless @user.id == session[:user].id
                   unless params[:user][:a].present?
                     @per = @permission.update_all(value: false)
                   end
                 end
               end
             end
             if params[:user][:a].present?
               format.html { redirect_to root_path }
             else
               format.html { redirect_to user_permissions_path }
             end
             format.json { render :index, status: :created, location: @user }
           else
             if params[:user][:a].present?
               format.html { redirect_to root_path }
             else
               format.html { render :edit }
             end
             format.json { render json: @user.errors, status: :unprocessable_entity }
           end
         end
       end
     end
  end

  def show
  end

  def new
    if params[:duplicate].present?
      @duplicate_user = User.find(params[:duplicate])
      @permissions = Permission.where(user_id: @duplicate_user.id)
    end
    @user = User.new
    @permission_action = PermissionAction.all
    @permission_section = PermissionSection.all
    @ps = Section.all
    @email = session[:user]["email"]
    @paps = PermissionActionPermissionSection.all
  end

  def destroy
    @user.destroy
    redirect_to user_permissions_path
  end

  def deactivate_user
   if @user.update(active: false)
     redirect_to user_permissions_path
   else
     redirect_to root_path
   end
  end

  def activate_user
    if @user.update(active: true)
      redirect_to user_permissions_path
    else
      redirect_to root_path
    end
  end
  private

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:email, :password, :firstname, :lastname).merge(studio_id: current_user.id, role: false, active: true, studio_name: current_user.studio_name, country_id: current_user.country_id )
  end
end
