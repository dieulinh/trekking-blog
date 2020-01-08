namespace :crawler do
  desc 'crawler for news'
  task crawl_news: :environment do
    res = WebsiteScaper.read_page_content

    res = res.stringify_keys
    readable_content = res["posts"]
    readable_content.each do |link|
      # Rails.cache.redis.set("hacker_posts:#{link['link']}", link.to_json)
      unless Rails.cache.redis.get("hacker_posts:#{link['link']}")
        Rails.cache.redis.set("hacker_posts:#{link['link']}", link.to_json)
      end
    end
  end
end
