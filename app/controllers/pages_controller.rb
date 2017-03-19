class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @developers = Developer.all
    @projects = Project.where.not(latitude: nil, longitude: nil)
    @hash = Gmaps4rails.build_markers(@projects) do |project, marker|
      marker.lat project.latitude
      marker.lng project.longitude
    end
  end
end
