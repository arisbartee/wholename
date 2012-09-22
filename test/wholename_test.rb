require 'test_helper'
require 'active_record'

ActiveRecord::Base.configurations={'test'=>{adapter:'sqlite3',database:':memory:'}}



class Person < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :middle_name, :nickname, :maiden_name
  acts_as_wholename
end
class WholenameTest < ActiveSupport::TestCase
  def setup
     ActiveRecord::Schema.define(:version => 1) do
      create_table :people do |t|
        t.column :first_name, :string
        t.column :last_name, :string
        t.column :middle_name, :string
        t.column :nickname, :string
        t.column :maiden_name, :string
      end
    end
  end

  def teardown
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end

  def test_last_name_only
    person = Person.new({:last_name => 'Smith'})
    assert_equal 'Smith', person.whole_name
    assert_equal 'Smith', person.short_name
  end
  def test_first_name_only
    person = Person.new({:first_name => 'John'})
    assert_equal 'John',  person.whole_name
    assert_equal 'John', person.short_name
  end
  def test_middle_name_only
    person = Person.new({:middle_name => 'Quincy'})
    assert_equal 'Quincy', person.whole_name
    assert_equal 'Quincy', person.short_name
  end
  def test_nickname_only
    person = Person.new({:nickname => 'Que'})
    assert_equal 'Que', person.whole_name
    assert_equal 'Que', person.short_name
  end

  def test_whole_name_with_middle_name
    person = Person.new({:first_name => 'Jane', :maiden_name => 'Johnson', :middle_name => 'Caroline', :last_name => 'Smith'})
    assert_equal 'Jane Caroline Smith', person.whole_name
  end

  def test_whole_name_without_middle_name
    person = Person.new({:first_name => 'Jane', :maiden_name => 'Johnson', :last_name => 'Smith'})
    assert_equal 'Jane Johnson Smith', person.whole_name
  end

end
