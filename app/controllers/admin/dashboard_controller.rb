class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']

  def show
    puts ENV['USERNAME']
    puts ENV['PASSWORD']
  end

end
