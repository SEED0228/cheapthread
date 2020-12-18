module ApplicationHelper
    def price_permission(list)
        list.list_elements.each do |list_element|
            if list_element.price.nil? || list_element.price == 0
                return false
            end
        end
        return true
    end

    def calorie_permission(list)
        list.list_elements.each do |list_element|
            if list_element.calorie.nil? || list_element.calorie == 0
                return false
            end
        end
        return true
    end
end
