def calculate_stock
	stock_prices = [4,2,8,7,3,9,5,1,6]
	min_price = stock_prices[0]
	max_profit = 0
	profits = []

	stock_prices.each do |stock|
	  current_price = stock
	  min_price = [min_price, current_price].min
	  max_profit = [max_profit, current_price-min_price].max
	  profits << max_profit
	end
  puts profits
	return profits.max
end

puts(calculate_stock)