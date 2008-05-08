begin
  Settings.defaults[:theme] = "toader"
  Settings.defaults[:subtitle] = 'Comunidad Catolica'
  Settings.defaults[:per_page] = 20
  Settings.defaults[:logo_title] = 'Comunidad Catolica Latina'
  Settings.defaults[:logo_subtitle] = "Donde Los Catolicos Latinos se Reúnen en Bangkok."
  Settings.defaults[:meta_title] = "Bienvenido a Comunidad Catolica Latina en Bangkok, Thailand"
  Settings.defaults[:meta_description] = "Donde los Catolicos Latinos se reúnen en Bangkok"
  Settings.defaults[:site_copyrights] = 'Copyrights 2008'
  Settings.defaults[:email] = "admin@ComunidadCatolica.com"
  Settings.defaults[:content_keywords] = "Catholic Church, Bangkok, Iglesia Catolica, Latina, Hispano, Tailandia, Thailand, Spanish, Espanol, Misa, Mass"
  Settings.defaults[:content_author] = "Comunidad Catolica Latina en Bangkok, Tailandia"
rescue => e
  puts "Please run pending migrations first. Settings table was not found"
end
  
