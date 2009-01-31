module CommentsHelper
  
  def user_comment_link(comment)
    if !comment.website_url.blank? && comment.website_url.to_s != "http://"
      link_to(comment.name, comment.website_url)
    else
      comment.name
    end
  end
  
end
