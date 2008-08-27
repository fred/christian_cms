module Admin::BaseHelper
  
  def approve_link(obj)
    if obj.approved
      link_to('Unapprove', 
        :controller => "admin/comments", :action => "unapprove", :id => obj
      )
    else
      link_to('Approve', 
        :controller => "admin/comments", :action => "approve", :id => obj
      )
    end
  end
end
