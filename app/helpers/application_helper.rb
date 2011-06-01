module ApplicationHelper
  def category_options
    options_for_select [['foo',1],['bar',2]]
  end

  def render_shadow_box(id, content)
    render :partial => 'shared/shadow_box', :locals => {:id => id, :content => content}
  end

  def link_to_populate(video)
    button_to('Add To Reel', populate_collection_path(current_collection, :video_id => video), :method => :post, :class => 'button')
  end
end
