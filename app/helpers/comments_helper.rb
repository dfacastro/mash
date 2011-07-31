module CommentsHelper
  def new_comment_if(condition, comment_id, &block)
    if condition
      content_tag("div", {:class => 'comment', "data-value" => comment_id, :id => 'fresh_comment', :style => 'display: none'}, &block)
    else
      content_tag("div", {:class => 'comment', "data-value" => comment_id}, &block)
    end
  end
end
