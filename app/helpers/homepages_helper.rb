module HomepagesHelper

  def display_creator(creator, klass)
    if(creator.is_a? String)
      creator_text = creator.empty? ? "" : "by #{creator}"
    else
      creator_text = ""
    end

    return content_tag(:small, "#{creator_text}", class: klass)
  end


end
