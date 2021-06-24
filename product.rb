class Product
    attr_accessor :name, :price, :taxes
    def initialize(name, type, price, imported)
        @name = name
        @type = type
        @price = price
        @imported = imported
        @taxes = 0
        @tax_percentaje = getProductTaxByType(type)
        calculateProductTaxes
    end

    private 

    def getProductTaxByType(type)
		case type.upcase
			when "BOOK", "BOOKS", "FOOD", "MEDICAL", "MEDICINE"
			return 0
			else
			return 10
		end
	end

    def calculateProductTaxes
        base_tax = 0
        import_tax = 0
        if @tax_percentaje > 0
          base_tax = @tax_percentaje * @price / 100.00.to_f
        end
        if @imported
          import_tax = @price * 5.00 / 100.00.to_f
        end
        @taxes = roundTax(base_tax + import_tax)
    end

    def roundTax(tax)
        return (tax / 0.05.to_f).round * 0.05
    end 
end