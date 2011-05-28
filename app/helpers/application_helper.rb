module ApplicationHelper
  def category_options
    [['foo',1],['bar',2]]
  end

  def render_shadow_box(id, content)
    render :partial => 'shared/shadow_box', :locals => {:id => id, :content => content}
  end
end
