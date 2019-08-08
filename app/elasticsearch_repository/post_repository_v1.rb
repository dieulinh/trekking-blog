class PostRepositoryV1 < ApplicationRepository

  #############
  #  Repository Settings
  #
  #
  #############
  def setting_repository
    settings "index": {
      "number_of_shards": 1
    } do
      mapping dynamic: 'false' do
        indexes :title, type: 'keyword'
        indexes :category, type: 'keyword'
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
      category: "#{document.category}",
      thumb_url: "#{document.thumb_url}"
    }.as_json
  end

  def save(document)
    serialized = serialize(document)
    type = document_type || __get_type_from_class(klass || document.class)
    document_attrs = { index: index_name, type: 'post_repository_v1', body: serialized }
    document_attrs = document_attrs.merge({id: document.id}) if document.id

    client.index(document_attrs)
  end

  # def destroy(document)
  #   serialized = serialize(document)
  #   type = document_type || __get_type_from_class(klass || document.class)


  #   client.index(document_attrs)
  # end
end
