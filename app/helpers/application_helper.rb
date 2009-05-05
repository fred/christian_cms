# Methods added to this helper will be available to all templates in the application.
require 'md5'
module ApplicationHelper
  
  
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

  def avatar_for(user, size=32)
    image_tag "http://www.gravatar.com/avatar.php?gravatar_id=#{MD5.md5(user.email)}&rating=PG&size=#{size}", :size => "#{size}x#{size}", :class => 'photo'
  end

  def feed_icon_tag(title, url)
    (@feed_icons ||= []) << { :url => url, :title => title }
    link_to image_tag('feed-icon.png', :size => '14x14', :alt => "Subscribe to #{title}"), url
  end
  
  
  def pagination collection
    if collection.page_count > 1
      "<p class='pages'>" + 'Pages'[:pages_title] + ": <strong>" + 
      will_paginate(collection, :inner_window => 10, :next_label => "next"[], :prev_label => "previous"[]) +
      "</strong></p>"
    end
  end
  
  def next_page collection
    unless collection.current_page == collection.page_count or collection.page_count == 0
      "<p style='float:right;'>" + link_to("Next page"[], { :page => collection.current_page.next }.merge(params.reject{|k,v| k=="page"})) + "</p>"
    end
  end

  def windowed_pagination_links(pagingEnum, options)
    link_to_current_page = options[:link_to_current_page]
    always_show_anchors = options[:always_show_anchors]
    padding = options[:window_size]

    current_page = pagingEnum.page
    html = ''

    #Calculate the window start and end pages 
    padding = padding < 0 ? 0 : padding
    first = pagingEnum.page_exists?(current_page  - padding) ? current_page - padding : 1
    last = pagingEnum.page_exists?(current_page + padding) ? current_page + padding : pagingEnum.last_page

    # Print start page if anchors are enabled
    html << yield(1) if always_show_anchors and not first == 1

    # Print window pages
    first.upto(last) do |page|
      (current_page == page && !link_to_current_page) ? html << page : html << yield(page)
    end

    # Print end page if anchors are enabled
    html << yield(pagingEnum.last_page) if always_show_anchors and not last == pagingEnum.last_page
    html
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
