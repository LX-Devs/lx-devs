class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :edit, :update]


  def new
    @developer = Developer.new
  end

  def edit
    if current_user.id == @developer.user.id
      @photos = @developer.photo
    else
      redirect_to :index, notice: "You can't make changes to this profile."
    end
  end

  def create
    @developer = current_user.developer.build(developer_params)
    if @developer.save
      redirect_to :show, notice: "Your profile has been successfully saved!"
    else
      render :new, alert: "Your profile could not be saved."
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

  private

  def developer_params
    params.require(:developer).permit(:username, :first_name, :last_name, :title, :description, :language1, :language2, :language3, :language4, :nationality, :birthday, photos: [])
  end


  def set_developer
  @developer = Developer.find(params[:username])
  end

end
