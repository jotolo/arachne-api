class FtpFile < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, presence: true
  validates :path, presence: true

  belongs_to :ftp_server

  before_save :set_address

  settings index:
               {
                   number_of_shards: 1,
                   analysis: { filter: { autocomplete_filter: { type: 'edge_ngram',
                                                                min_gram: 1,
                                                                max_gram: 20 } },
                               analyzer: { autocomplete: { type: 'custom',
                                                           tokenizer: 'standard',
                                                           filter: %w(lowercase autocomplete_filter) }
                               }
                   }
               } do
    mappings dynamic: 'false' do
      indexes :name, type: 'text', analyzer: 'autocomplete'
      indexes :path, type: 'text', analyzer: 'autocomplete'
      indexes :address, type: 'text', analyzer: 'autocomplete'
    end
  end

  def self.search(query, search_count)
    __elasticsearch__.search(
        size: if search_count.nil?
                10
              else
                search_count > 10000 ? 10000 : search_count
              end,
        query: { multi_match: { query: query,
                                analyzer: 'standard',
                                fields: ['name^15', 'address^5', 'path'],
                                type: 'cross_fields' } },
        #sort: [{ name:  { order: 'asc' } }]
        )
  end

  def as_indexed_json(options = {})
    as_json(only: [:name, :path, :address])
  end

  private
  def set_address
    #self.address = "#{ftp_server.host}/#{path}/#{name}"
    self.address = "ftp://#{File.join(ftp_server.host,path,name)}"
  end
end
