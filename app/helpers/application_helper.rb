module ApplicationHelper

  def site_title
    'vaope'
  end

  def site_description
    'VaoPe te permite conocer y dar a conocer locales en el Per&uacute;'
  end

  def opengraph_tags
    tags = {}
    case params[:controller]
      when 'home'
        tags = {'og:title' => site_title, 'og:description' => site_description}
      when 'areas'
      when 'categories'
      when 'places'
    end

    content = ""

    tags.each { |key, value|
      content += "<meta name=\"#{key}\" content=\"#{value}\" />\n"
    }
    content.html_safe
  end

end
