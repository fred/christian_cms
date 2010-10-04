#############
### Users ###
#############
Factory.define :visitor, :class => User do |u|
  u.first_name 'John'
  u.login 'john'
  u.email 'john@localhost.local'
  u.password 'welcome'
  u.password_confirmation 'welcome'
  u.salt '622e1d1c910993450952455ce479374d5392aeba'
  u.crypted_password '50723e324f13ce37e27e26632ff0218747a2d67f' # welcome
  u.admin false
end

Factory.define :fred, :class => User do |u|
  u.first_name 'Fred'
  u.login 'fred'
  u.email "fred@localhost.local"
  u.password 'welcome'
  u.password_confirmation 'welcome'
  u.salt '622e1d1c910993450952455ce479374d5392aeba'
  u.crypted_password '50723e324f13ce37e27e26632ff0218747a2d67f' # welcome
  u.admin true
end

Factory.define :admin, :class => User do |u|
  u.first_name 'Admin'
  u.login  'admin'
  u.email 'admin@localhost.local'
  u.password 'welcome'
  u.password_confirmation 'welcome'
  u.salt '622e1d1c910993450952455ce479374d5392aeba'
  u.crypted_password '50723e324f13ce37e27e26632ff0218747a2d67f' # welcome
  u.admin true
end

Factory.define :marcela, :class => User do |u|
  u.first_name "marcela"
  u.login  'marcela'
  u.email 'marcela@localhost.local'
  u.password 'welcome'
  u.password_confirmation 'welcome'
  u.salt '622e1d1c910993450952455ce479374d5392aeba'
  u.crypted_password '50723e324f13ce37e27e26632ff0218747a2d67f' # welcome
  u.admin false
end
