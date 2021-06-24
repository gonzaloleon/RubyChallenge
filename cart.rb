#!/usr/bin/env ruby
class Float

  def round_tax
    (self / 0.05.to_f).round * 0.05
  end

end

class Purchase
	attr_accessor :products, :basic_tax, :import_tax, :total
	Product = Struct.new(:product_name, :product_type, :product_tax_percentaje, :product_tax, :product_sale_price, :product_is_imported, :product_imported_tax)
	Purchase_Line = Struct.new(:quantity, :Product)
	def initialize()
		@products = []
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
	  product_tax_percentaje = getProductTypeTax(product_type)
	  product_tax = 0
	  product_import_tax = 0
	  product_sale_price = product_sale_price.to_f
	  if product_tax_percentaje > 0
	    product_tax = quantity * (product_tax_percentaje * product_sale_price / 100.00.to_f).round_tax
	  end
	  if product_imported
		product_import_tax = quantity * (product_sale_price * 5.00 / 100.00.to_f).round_tax
	  end
	  
      products.push Purchase_Line.new(quantity, Product.new(product_name, product_type, product_tax_percentaje, product_tax, product_sale_price, product_imported, product_import_tax))
	  
	  if product_imported
		@import_tax += product_import_tax
	  end
	  if product_tax_percentaje > 0
		@basic_tax += product_tax
	  end
	  @total += quantity*product_sale_price + product_tax + product_import_tax
    end
	
	def CloseInvoice()
		if @products.nil? 
			puts "There is no products in your cart - $ 0"
		elsif @products.respond_to?("each")
			@products.each do |prod|
				puts "#{prod.quantity} #{prod.Product.product_name}: $ #{ (prod.quantity*prod.Product.product_sale_price + prod.Product.product_tax + prod.Product.product_imported_tax).round(2)}"
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
  
  purch = Purchase.new
  purch.addProduct(2, "Books", "Book", 12.49, false)
  purch.addProduct(1, "Music CD", "Music", 14.99, false)
  purch.addProduct(1, "Chocolate bar", "FOOD", 0.85, false)
  
  purch.CloseInvoice()
  
  puts ""
  puts "-> INPUT 2 "
  puts ""
  
  purch = Purchase.new
  purch.addProduct(1, "Box of chocolates", "FOOD", 10.00, true)
  purch.addProduct(1, "Bottle of perfume", "OTHER", 47.50, true)
  
  purch.CloseInvoice()
  
  puts ""
  puts "-> INPUT 3 "
  puts ""
  
  purch = Purchase.new
  purch.addProduct(1, "Bottle of perfume A", "Others", 27.99, true)
  purch.addProduct(1, "Bottle of perfume B", "Others", 18.99, false)
  purch.addProduct(1, "Pack of headache pills", "MEDICINE", 9.75, false)
  purch.addProduct(3, "Boxes of chocolate", "FOOD", 11.25, true)
  
  purch.CloseInvoice()
end