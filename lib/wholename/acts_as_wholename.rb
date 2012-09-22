module HumanRecord
  module ActsAsWholename 
    extend ActiveSupport::Concern
    included do
    end

    module ClassMethods
      def acts_as_wholename(options = {})
        # Here you can put additional association for the
        # target class.
        # belongs_to :role
        # add class and istance methods
      end
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
ActiveRecord::Base.send :include, HumanRecord::ActsAsWholename
