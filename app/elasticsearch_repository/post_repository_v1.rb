class PostRepositoryV1 < ApplicationRepository

  def setting_repository
#     curl -X PUT "localhost:9200/my_index/_doc/1" -H 'Content-Type: application/json' -d'
# {
#   "create_date": "2015/09/02"
# }
# '


    settings "index": {
      "number_of_shards": 1
    } do
      mapping dynamic: 'false' do
        indexes :title, type: 'keyword'
        indexes :description, type: 'keyword'
        indexes :slug, type: 'text'
        indexes :thumb_url, type: 'text'
      end
    end
  end
  def serialize(document)
    {
      title: "#{document.title}",
      description: "#{document.description}",
      slug: "#{document.slug}",
      thumb_url: "#{document.thumb_url}"
    }.as_json
  end

  def save(document)
    serialized = serialize(document)
    id   = document.id
    type = document_type || __get_type_from_class(klass || document.class)
    client.index( { index: index_name, type: type, id: id, body: serialized })
  end
end
