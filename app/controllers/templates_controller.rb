class TemplatesController < ApplicationController
  caches_page :page if Rails.env == :production

  def page
    @path = params[:path]
    render :template => 'templates/' + @path, :layout => nil
  end

end
