require 'elasticsearch/rails/tasks/import'

namespace :elasticsearch do

  task reindex: [:delete_indexes, :create_indexes, :index_db]

  task create_indexes: :environment do
    indexes_types = [FtpFile]
    indexes_types.each do |type|
      puts "Creating index #{type.index_name}..."
      Elasticsearch::Model.client.indices.create(index: type.index_name,
                                                 body: { settings: type.settings.to_hash,
                                                         mappings: type.mappings.to_hash })
      puts 'Done'
    end

    indexes_types.each do |type|
      type.find_in_batches do |records|
        puts "Bulk index #{type.index_name}..."
        type.__elasticsearch__.client.bulk(index: type.__elasticsearch__.index_name,
                                           type: type.__elasticsearch__.document_type,
                                           body: prepare_records(records),
                                           refresh: true)
        puts 'Done'
      end
    end
  end

  def self.prepare_records(records)
    records.map do |data|
      { index: { _id: data.id, data: data.as_indexed_json } }
    end
  end

  task delete_indexes: :environment do
    indexes_types = [FtpFile]
    indexes_types.each do |type|
      puts "Deleting index #{type.index_name}..."
      Elasticsearch::Model.client.indices.delete index: type.index_name rescue nil
      puts 'Done'
    end
  end

  task :delete_all_indexes => :environment do
    puts 'Deleting all indexes...'
    Elasticsearch::Model.client.indices.delete index: '_all' rescue nil
    puts 'Done'
  end

  task :index_db => :environment do
    indexes_types = [FtpFile]
    indexes_types.each do |type|
      puts "Importing index #{type.index_name} from database..."
      type.import(query: -> {all} ) rescue nil
    end
    puts 'Done'
  end

end