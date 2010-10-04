# -*- encoding : utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def w3c_date(date)
    date.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00")
  end
  
  def tag_link(tag)
    url_for :controller => "articles", :action => "tags", :tag => tag
  end
  
  def display_bold(bol)
    if bol
      "bold"
    else
      ""
    end
  end
  
  def admin_home
    url_for :controller => "admin/dashboard"
  end
  
  # returns a link from the menu_items table
  # and take care of about_blank
  def menu_item_link(m)
    options = {}
    if m.new_page
      options = {:target => "_blank"}
    end
    link_to m.title, m.url, options
  end
  
  # returns a yes/no image small size
  def boolean_to_image_lock(bol)
    if bol && (bol == true)
      return image_tag("/images/lock22.png", :class => "align-center")
    else
      return nil
    end
  end
  
  # returns a yes/no image small size
  def boolean_to_image_small(bol)
    if bol
      return image_tag("/images/yes_small.png", :class => "align-center")
    else
      return image_tag("/images/no_small.png", :class => "align-center")
    end
  end
  
  # returns a proper image bigger
  def boolean_to_image_big(bol)
    if bol
      return image_tag("/images/yes.png", :class => "align-center")
    else
      return image_tag("/images/no.png", :class => "align-center")
    end
  end

  # returns a proper image 
  def boolean_to_word(bol)
    if bol 
      return "Yes"
    else
      return "No"
    end
  end
  
  def years_array
    years = []
    Time.now.year.downto(1970) do |year|
      years << year.to_s
    end
    years
  end
  
  def month_birthdays_path
    url_for(:controller => "birthdays", :month => Time.now.month)
  end
  
  # convenient plugin point
  def head_extras
  end
  
  def submit_tag(value = "Save Changes"[], options={} )
    or_option = options.delete(:or)
    return super + "<span class='button_or'>"+"or"[]+" " + or_option + "</span>" if or_option
    super
  end

  def ajax_spinner_for(id, spinner="spinner.gif")
    "<img src='/images/#{spinner}' style='display:none; vertical-align:middle;' id='#{id.to_s}_spinner'> "
  end

  def feed_icon_tag(title, url)
    (@feed_icons ||= []) << { :url => url, :title => title }
    link_to image_tag('feed-icon.png', :size => '14x14', :alt => "Subscribe to #{title}"), url
  end
  
  
  def random_string(len)
    rand_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "0123456789" + "abcdefghijklmnopqrstuvwxyz"
    rand_max = rand_chars.size 
    ret = "" 
    len.times{ ret << rand_chars[rand(rand_max)] } 
    ret 
  end
  
  def authorized_admin?
    logged_in? && (current_user.admin == true)
  end
  

end
