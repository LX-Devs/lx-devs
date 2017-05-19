class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :edit, :destroy]
  before_action :set_developer_by_id, only: [:update]
  before_action :set_user


  def new
    if @user.developer
      @developer = @user.developer
      redirect_to edit_developer_path(@developer.username.downcase), alert: "You already have a developer profile. You can edit it here!"
    else
      @developer = Developer.new
      @developer.projects.build
    end
  end

  def edit
    if @user.id == @developer.user.id
      @photos = @developer.photo
    else
      redirect_to developer_path(current_user.developer.username.downcase), alert: "You can't make changes to this profile."
    end
  end

  def create
    @developer = Developer.new(developer_params)
    @developer.user = current_user
    if @developer.save
      if params[:photos]
        params[:photos].each do |photo|
          @developer.photo.create(image: photo)
        end
      end
      if params[:projects]
        params[:projects].each do |project|
          @developer.project.create(project)
        end
      end

      # creates a new view partial file with the username of the developer
      viewfile_path = "app/views/developers/profiles/_#{@developer.username.downcase}.html.erb"
      viewfile_content = "<\% content_for :head do %><%= stylesheet_link_tag '#{@developer.username.downcase}' %>\n<\% end %><h1>Hi <%= @developer.first_name %>!</h1><br><h2>You are now ready to create your view in the app!</h2>"
      File.open(viewfile_path, "w+") do |file|
        file.write(viewfile_content)
      end

      # creates a new css file with the username of the developer
      cssfile_path = "app/assets/stylesheets/#{@developer.username.downcase}.scss"
      cssfile_content = "
        @import 'bootstrap-sprockets';\n
        @import 'bootstrap';\n
        @import 'font-awesome-sprockets';\n
        @import 'font-awesome';\n
        @import 'vendor/index';\n
      "
      File.open(cssfile_path, "w+") do |file|
        file.write(cssfile_content)
      end

      # writes a new file in the config/initialiazers/assets.rb file to precompile the new css file for the user
      assetsconfig_path = "config/initializers/assets.rb"
      assetsconfig_content = "Rails.application.config.assets.precompile += %w( #{@developer.username.downcase}.scss )"
      File.open(assetsconfig_path, "a") do |file|
        file.puts(assetsconfig_content)
      end

      redirect_to root_path, notice: "Your profile has been successfully saved! Please restart the server to see your profile live!"
    else
      render :new, alert: "Oops! There was an error when saving :( Please try to create your profile again."
    end

  end

  def show
    @disable_navigation = true
    @disable_stylesheets = true
    @courses = @developer.projects.where(type: "course")
    @projects = @developer.projects.where(type: "project")
    @jobs = @developer.projects.where(type: "job")
    @charity_work = @developer.projects.where(type: "charity work")
  end

  def update
    if @developer.update(developer_params)
      if params[:photos]
        params[:photos].each do |photo|
          @developer.photo.create(image: photo)
        end
      end
      if params[:projects]
        params[:projects].each do |project|
          @developer.project.create(project)
        end
      end
      redirect_to developer_path(current_user.developer.username.downcase), notice: "Your profile has been successfully updated! Check if your info was changed correctly."
    else
      redirect_to edit_developer_path(@developer.username.downcase), alert: "Oops! There was an error when saving :( Please try to edit your profile again."
    end
  end

  def destroy
    if @developer.destroy
      # creates a new view partial file with the username of the developer
      viewfile_path = "app/views/developers/profiles/_#{@developer.username.downcase}.html.erb"
      File.delete(viewfile_path)

      # creates a new css file with the username of the developer
      cssfile_path = "app/assets/stylesheets/#{@developer.username.downcase}.scss"
      File.delete(cssfile_path)

      # writes a new file in the config/initialiazers/assets.rb file to precompile the new css file for the user
      assetsconfig_path = "config/initializers/assets.rb"
      assetsconfig_content = "Rails.application.config.assets.precompile += %w( #{@developer.username.downcase}.scss )"
      text = File.read(assetsconfig_path)
      text_minus_assets_config = text.gsub(assetsconfig_content, "")
      File.open(assetsconfig_path, "w") {|file| file.puts text_minus_assets_config }

      redirect_to root_path, notice: "Your profile has been successfully deleted!"
    else
      render :new, alert: "Oops! There was an error when deleting :( Please try to create again, or ask to get your files deleted from the master branch."
    end
  end


  private

  def developer_params
    params.require(:developer).permit( :username, :first_name, :last_name, :title, :description, :language1, :language2, :language3, :language4, :nationality, :birthday, photos: [], projects_attributes: [:name, :description, :date_completed, :url, :type, :_destroy, :id])
  end


  def set_developer
    @developer = Developer.find_by(username: params[:username])
  end

  # for update method, since it can only use ID to change an entry
  def set_developer_by_id
    @developer = Developer.find(params[:username])
  end

  def set_user
    @user = current_user
  end
end
