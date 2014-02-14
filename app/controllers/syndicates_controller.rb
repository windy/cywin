class SyndicatesController < ApplicationController
  def index
    @projects = Project.all
  end
end
