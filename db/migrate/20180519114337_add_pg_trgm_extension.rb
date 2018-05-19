class AddPgTrgmExtension < ActiveRecord::Migration[5.2]
  def change
    execute 'create extension pg_trgm;'

    add_index :products, :title, using: :gist, opclass: { title: :gist_trgm_ops }
  end
end
