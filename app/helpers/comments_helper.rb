module CommentsHelper
  def new_comment_if(condition, comment_id, user_id, &block)
    if condition
      if user_id == session[:user_id]
        content_tag("div", {:class => 'comment editable fresh_comment', "data-value" => comment_id, :id => 'fresh_comment', :style => 'display: none'}, &block)
      else
        content_tag("div", {:class => 'comment fresh_comment', "data-value" => comment_id, :id => 'fresh_comment', :style => 'display: none'}, &block)
      end
    else
      if user_id == session[:user_id]
        content_tag("div", {:class => 'comment editable', "data-value" => comment_id}, &block)
      else
        content_tag("div", {:class => 'comment', "data-value" => comment_id}, &block)
      end
    end
  end
end
