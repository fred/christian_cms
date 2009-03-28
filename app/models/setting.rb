class Setting < ActiveRecord::Base
  
  # Filters
  after_save :sweep_partial_cache
  
  ### Methods ###
  
	def self.set(k, v=nil)
		x = find_by_name(k)
		# Create if it doesn't exist yet, return result #
		return Setting.create(:name=>k, :value=>v) if x.nil?
		# Update if already exists, return result #
		return x.update_attributes(:value=>v)
	end

	def self.get(k)
		x = find_by_name(k)
		# Return nil gracefully if non-existent #
		return nil if x.nil?
		# Return value if exists #
		return x.value
	end

	def self.method_missing(meth, *args)
		# Weed out finds #
		if meth.to_s.match(/^find/)
			super
		elsif meth.to_s.match(/^(.*)=$/)
			return Setting.set($1, args.first)
		else
			return Setting.get(meth.to_s)
		end
	end
  
  private
  def sweep_partial_cache
    cache_dir = RAILS_ROOT+"/tmp/cache/views/*"
    FileUtils.rm_r(Dir.glob(cache_dir)) rescue Errno::ENOENT
    logger.debug("Cache '#{cache_dir}' delete.")
  end
  
  
end
