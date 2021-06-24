class Product
    attr_accessor :product_name, :product_sale_price, :product_tax, :product_import_tax
    def initialize(product_name, product_type, product_sale_price, product_is_imported)
        @product_name = product_name
        @product_type = product_type
        @product_sale_price = product_sale_price
        @product_is_imported = product_is_imported
        @product_tax_percentaje = getProductTaxByType(product_type)
        @product_tax = 0
        @product_import_tax = 0
        calculateProductTaxes
    end

    def getProductTaxByType(product_type)
		case product_type.upcase
			when "BOOK", "BOOKS", "FOOD", "MEDICAL", "MEDICINE"
			return 0
			else
			return 10
		end
	end

    def calculateProductTaxes
        if @product_tax_percentaje > 0
            @product_tax = roundTax(@product_tax_percentaje * @product_sale_price / 100.00.to_f)
          end
          if @product_is_imported
            @product_import_tax = roundTax(@product_sale_price * 5.00 / 100.00.to_f)
          end
    end

    def roundTax(tax)
        return (tax / 0.05.to_f).round * 0.05
    end 
end