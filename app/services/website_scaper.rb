require 'nokogiri'
require 'readability'
require 'open-uri'
class WebsiteScaper
  def self.call(url)
    get_html(url)
  end
  def self.get_html(url)
    Nokogiri::HTML(open(url))
  end
  def self.elements_from_selector(html, selector)
    html.css(selector)
  end
  def self.element_at_css(html, selector)
    html.at_css(selector)
  end
  def self.read_page_content(url="https://news.ycombinator.com/best")
    doc = get_html(url)
    my_result = elements_from_selector(doc, "a.storylink").map do |item|
      text = item.text
      link = item[:href]
      unless link.match(/http:\/\/*|https:\/\/*/)
        link = "https://news.ycombinator.com/#{link}"
      end
      begin
        content = parse_article(link)
        { link: link, text: text, short_content: content }.stringify_keys
      rescue
        { link: link, text: text, short_content: {} }.stringify_keys
      end
    end
    { posts: my_result }
  end

  def self.parse_article(url)
    begin
      source = open(url).read
      rbody = Readability::Document.new(source, :tags => %w[div p img a], :attributes => %w[src href], :remove_empty_nodes => true)
      images = rbody.images
      thumbnail = images.present? ? images[0] : nil
      short_desc = rbody.content
      {
        title: rbody.title,
        content: rbody.content,
        thumbnail: thumbnail,
        author: rbody.author,
        short_desc: short_desc
      }.stringify_keys
    rescue
      {
        title: '',
        content: '',
        thumbnail: '',
        author: '',
        short_desc: ''
      }.stringify_keys
    end
  end
end
