module HumanRecord
module Acts
   module Wholename 
     # included is called from the ActiveRecord::Base
     # when you inject this module

     def self.included(base) 
      # Add acts_as_roled availability by extending the module
      # that owns the function.
       base.extend AddActsAsMethod
     end 

     # this module stores the main function and the two modules for
     # the instance and class functions
     module AddActsAsMethod
       def acts_as_wholename(options = {})
        # Here you can put additional association for the
        # target class.
        # belongs_to :role
        # add class and istance methods

         class_eval <<-END
           include HumanRecord::Acts::Wholename::InstanceMethods    
         END
       end
     end

     # Istance methods
     module InstanceMethods 
      # doing this our target class
      # acquire all the methods inside ClassMethods module
      # as class methods.

       def self.included(aClass)
         aClass.extend ClassMethods
       end 

       module ClassMethods
         # Class methods  
         # Our random function.

        end

        def whole_name
            name = ''
            name += self.first_name + ' ' unless self.first_name.nil?
            name += self.middle_name + ' ' unless self.middle_name.nil?
            name += self.maiden_name + ' ' if self.middle_name.nil? and !self.maiden_name.nil?
            name += self.last_name + ' ' unless self.last_name.nil?
            name = self.nickname unless self.nickname.nil? and name != ''
            name.strip

        end

        def short_name
          name = self.first_name
          name ||= self.middle_name
          name ||= self.nickname
          name ||= self.last_name
          name ||= self.maiden_name
          name
        end
     end 
   end
end
end
