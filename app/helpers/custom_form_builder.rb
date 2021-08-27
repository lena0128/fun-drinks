class CustomFormBuilder < ActionView::Helpers::FormBuilder

    # if we call this method fields_for, we will overide the existing method.
    # we can use the FormBuilder in the form built with form_with and form_for 
    def my_fields_for(association)
           association_attributes_method = "#{association}_attributes="
           object_class_downcase = self.object.class.to_s.downcase
           association_attributes = "#{association}_attributes"
            if object.methods.include?(association.to_sym) && object.methods.include?(association_attributes_method.to_sym)
               object.send(association).each_with_index.map do |a, i|
                   new_object_name = "#{object_class_downcase}[#{association_attributes}][#{i}]"
                   new_form_builder = CustomFormBuilder.new(new_object_name, a, @template, @options)
                 # binding.pry
                 yield(new_form_builder)
                 if a.id
                   hidden_field(:id)
                 end
               end
            end.join("").html_safe
         end