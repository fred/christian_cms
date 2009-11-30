class SitemapController < ApplicationController
  def sitemap
    @articles = Article.find(:all, :select => 'id, permalink, updated_at, created_at', :order => "updated_at DESC")
    @buletins = Buletin.find(:all, :select => 'id, updated_at, created_at', :order => "updated_at DESC")
    headers["Content-Type"] = "text/xml"
    # set last modified header to the date of the latest entry.
    headers["Last-Modified"] = @articles[0].updated_at.httpdate
    respond_to do |format|  
      format.xml  
    end
  end
  
end