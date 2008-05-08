class CreateMoneyRates < ActiveRecord::Migration
  def self.up
    create_table :money_rates do |t|
      t.column :name,   :string
      t.column :convert_from,   :string
      t.column :convert_to,     :string
      t.column :convert_result, :string
      t.column :expire_time,    :integer
      t.timestamps
    end
    MoneyRate.create :name => "Thai bath to Dolar conversion",
      :convert_to => "THB",
      :convert_from => "USD",
      :expire_time => "86400"
  end

  def self.down
    drop_table :money_rates
  end
end
