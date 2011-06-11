module CollectionHelper
  def link_to_populate(video)
    collection_action('Add To Reel', 'populate', video)
  end

  def link_to_depopulate(video)
    collection_action('Remove', 'depopulate', video)
  end

  def collection_action(text, action, video)
    if current_collection
      path = send("#{action}_collection_path", current_collection, :video_id => video.id)
      options = {:method => :post, :class => 'button', :remote => :true, :id => "#{action}-#{video.id}"}
      button_to(text, path, options)
    end
  end
end
