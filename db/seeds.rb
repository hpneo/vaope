# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
cat_1 = Category.create(:name => 'Restaurantes')
cat_2 = Category.create(:name => 'Diversion')

Category.create(:parent_id => cat_1.id, :name => 'Pollerias')
Category.create(:parent_id => cat_1.id, :name => 'Chifas')
Category.create(:parent_id => cat_1.id, :name => 'Carnes a la parrilla')
Category.create(:parent_id => cat_1.id, :name => 'Pescados y mariscos')
Category.create(:parent_id => cat_1.id, :name => 'Comida Criolla')
Category.create(:parent_id => cat_1.id, :name => 'Cafes')

Category.create(:parent_id => cat_2.id, :name => 'Discotecas')
Category.create(:parent_id => cat_2.id, :name => 'Karaokes')
Category.create(:parent_id => cat_2.id, :name => 'Pubs')
Category.create(:parent_id => cat_2.id, :name => 'Cines')
Category.create(:parent_id => cat_2.id, :name => 'Lounges')