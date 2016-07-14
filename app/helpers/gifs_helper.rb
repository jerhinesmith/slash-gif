module GifsHelper
  def gif_tag(gif)
    tag = (gif.url =~ /gifv/ ? :video : :img)
    content = content_tag(tag, nil, src: gif.url)
    link = content_tag(:a, content, href: gif.url, target: '_none')

    content_tag(:div, link, class: 'thumbnail')
  end
end
