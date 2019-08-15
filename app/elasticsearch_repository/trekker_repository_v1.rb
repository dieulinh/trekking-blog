class TrekkerRepositoryV1 < ApplicationRepository

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
        indexes :role, type: 'keyword'
        indexes :description, type: 'keyword'
        indexes :trekker_name, type: 'keyword'
        indexes :id, type: 'text'
        indexes :location, type: 'keyword'
        indexes :location_lonlat, type: 'geo_point'
        indexes :updated_at, type: 'date'
      end
    end
  end

  def serialize(document)
    {
      id: "#{document.id}",
      role: "#{document.role}",
      description: "#{document.description}",
      trekker_name: "#{document.trekker_name}",
      location: "#{document.location}",
      location_lonlat: "#{document.location_lonlat}",
      updated_at: document.updated_at
    }.as_json
  end

  def save(document)
    serialized = serialize(document)
    type = document_type || __get_type_from_class(klass || document.class)
    document_attrs = { index: index_name, type: type, body: serialized }
    document_attrs = document_attrs.merge({id: document.id}) if document.id

    client.index(document_attrs)
  end
end
