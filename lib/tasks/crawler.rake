namespace :crawler do
  desc 'crawler for news'
  task crawl_news: :environment do
    res = WebsiteScaper.read_page_content

    res = res.stringify_keys
    readable_content = res["posts"]
    readable_content.each do |link|
      today = Date.today.to_s
      # Rails.cache.redis.set("hacker_posts:#{link['link']}", link.to_json)
      cache_key = "hacker_posts:#{link['link']}"
      unless Rails.cache.redis.get(cache_key)
        Rails.cache.redis.set(cache_key, link.to_json)
      end
    end
  end
  task save_news: :environment do
    posts_keys = Rails.cache.redis.keys.select {|k| k=~/hacker_posts:*/ }
    posts = posts_keys.map {|k| JSON.parse(Rails.cache.redis.get(k)) }

    posts_hash = posts.map {|post| {'title' => post['text'], 'description' => post['short_content']['short_desc'], 'original_url' => post['link']}}
    posts_hash.each do |post|
      Post.create(post.merge(content: post['description'], category: 'technology', user_id: User.first.id))
    end
    posts_keys.each {|k| Rails.cache.redis.del(k) }
  end
end
