require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = "http://eagertrekker.com"
SitemapGenerator::Sitemap.sitemaps_host = "http://eagertrekker.com"
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.create do
  add '/#/', :changefreq => 'daily', :priority => 0.9
  add '/#/posts', :changefreq => 'daily'
  add '/#/login', :changefreq => 'weekly'
  add '/#/register', :changefreq => 'weekly'
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
