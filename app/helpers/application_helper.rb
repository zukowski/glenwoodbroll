module ApplicationHelper
  def category_options
    options_for_select [['foo',1],['bar',2]]
  end

  def render_shadow_box(id, content)
    render :partial => 'shared/shadow_box', :locals => {:id => id, :content => content}
  end

  def link_to_populate(video)
    if current_collection
      button_to('Add To Reel', populate_collection_path(current_collection, :video_id => video.id), :method => :post, :class => 'button add-to-reel')
    end
  end

  def link_to_depopulate(video)
    if current_collection
      button_to('Remove', depopulate_collection_path(current_collection, :video_id => video.id), :method => :post, :class => 'button')
    end
  end

  def select_tag_for_switch_collection
    select_tag(:collection_id, options_from_collection_for_select(current_user.collections, :id, :name, current_collection.id))
  end
end
