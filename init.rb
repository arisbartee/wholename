
require 'acts_as_wholename'
ActiveRecord::Base.send(:include, HumanRecord::Acts::Wholename)