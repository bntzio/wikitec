module WikisHelper
  def tagging_list(wiki)
    raw wiki.tag_list.map { |t| link_to t, tag_path(t) }.join(', ')
  end
end
