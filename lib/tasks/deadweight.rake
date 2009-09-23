# lib/tasks/deadweight.rake

begin
  require 'deadweight'
rescue LoadError
end

desc "run Deadweight on staging server"
task :deadweight do
  dw = Deadweight.new

  dw.mechanize = true

  dw.root = 'http://localhost:3000'

  dw.stylesheets = %w( /stylesheets/toader/site.css )

  dw.pages = %w( / /articles /events /users )

  dw.pages << proc {
    fetch('/login')
    form = agent.page.forms.first
    form.username = 'username'
    form.password = 'password'
    agent.submit(form)
    fetch('/secret-page')
  }

  dw.ignore_selectors = /hover|lightbox|superimposed_kittens/

  puts dw.run
end