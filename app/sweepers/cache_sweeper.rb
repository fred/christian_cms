class CacheSweeper < ActionController::Caching::Sweeper
  observe Article, Birthday, Settings, MenuItem, Event

  def after_save(record)
    expire_fragment(%r{articles/*})
    expire_fragment(%r{footer})
    expire_fragment(%r{header})
    expire_fragment(%r{side_column})
  end
    
end