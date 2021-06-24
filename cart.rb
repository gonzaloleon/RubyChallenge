require "./product.rb"
require "./cart_line.rb"

class Cart
	attr_accessor :cart_line, :basic_tax, :import_tax, :total
	
	def initialize()
		@cart_line = []
		@total = 0
		@import_tax = 0
		@basic_tax = 0
    end
    
	def getProductTypeTax(product_type)
		case product_type.upcase
			when "BOOK", "BOOKS", "FOOD", "MEDICAL", "MEDICINE"
			return 0
			else
			return 10
		end
	end
	
	def addProduct(quantity, product_name, product_type, product_sale_price, product_imported)
	  prod = Product.new(product_name, product_type, product_sale_price, product_imported)

	  product_tax_percentaje = getProductTypeTax(product_type)
	  product_tax = prod.product_tax
	  product_import_tax = prod.product_import_tax
	  product_sale_price = product_sale_price
	  if product_tax > 0
	    product_tax = quantity * product_tax
		@basic_tax += product_tax
	  end
	  if product_imported && product_import_tax > 0
		product_import_tax = quantity * product_import_tax
		@import_tax += product_import_tax
	  end
	  
      cart_line.push Cart_Line.new(quantity, prod)
	  
	  @total += quantity*product_sale_price + product_tax + product_import_tax
    end
	
	def CloseInvoice()
		if @cart_line.nil? 
			puts "There is no products in your cart - $ 0"
		elsif @cart_line.respond_to?("each")
			@cart_line.each do |prod|
				puts "#{prod.quantity} #{prod.product.product_name}: $ #{ (prod.quantity*prod.product.product_sale_price + prod.product.product_tax + prod.product.product_import_tax).round(2)}"
			end
			puts "-----------------------"
			puts "Sales Taxes: #{(import_tax + basic_tax).round(2)}"
			puts "Total $ #{total.round(2)}"
			puts "*** Taxes Details ***"
			puts "Basic tax $ #{basic_tax.round(2)}"
			puts "Import duty $ #{import_tax.round(2)}"
		end
	end
end

if __FILE__ == $0
  
  puts "-> INPUT 1 "
  puts ""
  
  purch = Cart.new
  purch.addProduct(2, "Books", "Book", 12.49, false)
  purch.addProduct(1, "Music CD", "Music", 14.99, false)
  purch.addProduct(1, "Chocolate bar", "FOOD", 0.85, false)
  
  purch.CloseInvoice()
  
  puts ""
  puts "-> INPUT 2 "
  puts ""
  
  purch = Cart.new
  purch.addProduct(1, "Box of chocolates", "FOOD", 10.00, true)
  purch.addProduct(1, "Bottle of perfume", "OTHER", 47.50, true)
  
  purch.CloseInvoice()
  
  puts ""
  puts "-> INPUT 3 "
  puts ""
  
  purch = Cart.new
  purch.addProduct(1, "Bottle of perfume A", "Others", 27.99, true)
  purch.addProduct(1, "Bottle of perfume B", "Others", 18.99, false)
  purch.addProduct(1, "Pack of headache pills", "MEDICINE", 9.75, false)
  purch.addProduct(3, "Boxes of chocolate", "FOOD", 11.25, true)
  
  purch.CloseInvoice()
end