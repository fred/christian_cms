############
### Articles
############
Factory.define :article_one, :class => Article do |u|
  u.title "Quienes Somos"
  u.permalink "quienes_somes"
  u.category "otro"
  u.user { Factory(:marcela) }
  u.author "marcela"
  u.short_body "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."
end
Factory.define :article_two, :class => Article do |u|
  u.title "Consejo Pastoral/Horarios"
  u.permalink "contactenos"
  u.category "otro"
  u.user { Factory(:marcela) }
  u.author "marcela"
  u.short_body "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."
end

Factory.define :article_three, :class => Article do |u|
  u.title "Mapa / Como llegar"
  u.permalink "mapa"
  u.category "otro"
  u.user { Factory(:fred) }
  u.author "fred"
  u.short_body "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."
end

Factory.define :article_four, :class => Article do |u|
  u.title "Fotos de despedida de la Familia Rodriguez 2008"
  u.permalink "fotos-de-despedida-de-la-familia-rodriguez-2008"
  u.category "noticia"
  u.user { Factory(:admin) }
  u.author "admin"
  u.short_body "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."
end

