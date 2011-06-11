module ApplicationHelper
  def render_shadow_box(id, content)
    render :partial => 'shared/shadow_box', :locals => {:id => id, :content => content}
  end

  def select_tag_for_switch_collection
    select_tag(:collection_id, options_from_collection_for_select(current_user.collections, :id, :name, current_collection.id))
  end
end
