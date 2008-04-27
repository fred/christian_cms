class MoneyRate < ActiveRecord::Base
    
  def self.update_rate
    rate = MoneyRate.get_rate("USD","THB")
    logger.info("--- Updating Rate")
    if rate_result = GoogleQuery::Currency.get("#{rate.convert_from} to #{rate.convert_to}")
      rate.convert_result = rate_result
      rate.save
      logger.info("--- Rate Updated")
    end
  end
  
  def self.get_rate(from,to)
    # find Rate in the DB
    MoneyRate.find(:first, :conditions => ["convert_from = ? AND convert_to = ?", from, to])
  end
  
end
