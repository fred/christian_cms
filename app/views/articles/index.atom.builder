atom_feed(:url => formatted_article_url(:atom)) do |feed|
  feed.title(Settings.title)
  feed.description(Settings.subtitle)
  feed.updated(@articles.last ? @articles.last.published_at : Time.now.utc)

  for post in @articles
    feed.entry(post) do |xml|
      
      xml.title(post.title)
      xml.description(post.short_body)
      xml.content(post.short_body, :type => 'html')
      xml.author(Settings.meta_content_author)               
      xml.pubDate(post.published_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
      xml.published(post.published_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
      xml.updated(post.published_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
      xml.link(url_for(:id => post, :action => 'show', :controller => 'articles', :only_path => false, :protocol => 'http'))
      xml.guid(url_for(:id => post, :action => 'show', :controller => 'articles', :only_path => false, :protocol => 'http'))
      
      xml.author do |author|
        author.name(Settings.meta_content_author)
        author.email(Settings.email)
      end
    end
  end
end