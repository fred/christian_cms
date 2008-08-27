xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(Settings.title)
    xml.description(Settings.subtitle)
    xml.language('en-us')
    for post in @articles
      xml.item do
        xml.title(post.title)
        xml.description(post.title)
        xml.author(Settings.meta_content_author)               
        xml.pubDate(post.published_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.published(post.published_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.updated(post.published_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
        xml.link(url_for(:id => post, :action => 'show', :controller => 'articles', :only_path => false, :protocol => 'http'))
        xml.guid(url_for(:id => post, :action => 'show', :controller => 'articles', :only_path => false, :protocol => 'http'))
      end
    end
  }
}