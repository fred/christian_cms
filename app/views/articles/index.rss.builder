xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title(Settings.rss_title)
    xml.description(Settings.rss_description)
    xml.language(Settings.rss_language)
    xml.generator(Settings.rss_generator)
    xml.managingEditor(Settings.rss_managing_editor)
    xml.webMaster(Settings.webmaster_email)
    xml.source(Settings.rss_title)
    xml.lastBuildDate(Article.last_published_date.strftime("%a, %d %b %Y %H:%M:%S %z"))
    for post in @articles
      xml.item do
        xml.title(post.title)
        xml.source(Settings.rss_title)
        xml.description(post.short_body)
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