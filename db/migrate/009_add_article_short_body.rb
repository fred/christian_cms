class AddArticleShortBody < ActiveRecord::Migration
  def self.up
    add_column :articles, :short_body, :text, :default => nil
    add_column :articles, :expires_on, :datetime
    Article.reset_column_information
    Article.find(:all).each do |t|
      t.short_body = t.body
      if t.save
        putc '.'
      end
    end
  end

  def self.down
    remove_column :articles, :short_body
    remove_column :articles, :expires_on
  end
end
