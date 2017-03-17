class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :edit, :update]


  def new
    @developer = Developer.new
    @developer.projects.build
  end

  def edit
    if current_user.id == @developer.user.id
      @photos = @developer.photo
    else
      redirect_to :index, notice: "You can't make changes to this profile."
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
      render :show, notice: "Your profile has been successfully saved!"
    else
      render :new, alert: "Your profile could not be saved."
    end

  end

  def show
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
    redirect_to :show, notice: "Your profile has been successfully updated!"
    end
  end

  private

  def developer_params
    params.require(:developer).permit(:username, :first_name, :last_name, :title, :description, :language1, :language2, :language3, :language4, :nationality, :birthday, photos: [], projects_attributes: [:name, :description, :date_completed, :url, :type])
  end


  def set_developer
    @developer = Developer.find_by(username: params[:username])
  end

end
