module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def current_page_params
    request.params.slice("youtube_id","sort","direction","leader_id","follower_id","channel_id")
  end

  def form_for_object_from_param(param)
    form_for_params = params.fetch(param, {})

    JSON.parse(form_for_params.to_json,
                object_class: OpenStruct)
  end

  

end