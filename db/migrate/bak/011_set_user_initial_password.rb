class SetUserInitialPassword < ActiveRecord::Migration
  def self.up
    # update existing records
    say_with_time "Updating Users..." do

      rand_chars = "abcdefghijklmnopqrstuvwxyz"
      rand_max = rand_chars.size
      
      User.find(:all, :conditions => ["id > 1"]).each do |user|
        login = ""
        6.times do
          login << rand_chars[rand(rand_max)] 
        end
        user.login = login
        user.initial_password = login
        user.password = login
        user.password_confirmation = login
        user.save
      end
    end
    
  end

  def self.down
  end
end
