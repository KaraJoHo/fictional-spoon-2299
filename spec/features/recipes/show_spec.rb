require 'rails_helper' 

RSpec.describe "Recipes Show Page" do 
  let!(:good_pasta) {Recipe.create!(name: "Good Pasta", complexity: 2, genre: "Italian")}
  let!(:rosemary) {good_pasta.ingredients.create!(name: "Rosemary", cost: 1)}
  let!(:tomato) {good_pasta.ingredients.create!(name: "Tomato", cost: 4)}
  let!(:pasta) {good_pasta.ingredients.create!(name: "Pasta", cost: 2)}

  let!(:garlic) {Ingredient.create!(name: "Garlic", cost: 1)}

  describe 'When visiting recipe show page(/recipes/:id)' do 
    it 'has receipes name, complexity, genre and the ingredients' do 
      visit "/recipes/#{good_pasta.id}"

      expect(page).to have_content(good_pasta.name)
      expect(page).to have_content(good_pasta.complexity)
      expect(page).to have_content(good_pasta.genre)
      expect(page).to have_content(rosemary.name)
      expect(page).to have_content(tomato.name)
      expect(page).to have_content(pasta.name)
    end

    it 'has the total cost of ingredients in the recipe' do 
      visit "/recipes/#{good_pasta.id}"

      expect(page).to have_content("Total Cost: 7")
    end

    it 'has a form to add an ingredient by an existing ingredient id' do
      visit "/recipes/#{good_pasta.id}"

      expect(page).to have_content("Add Ingredient")
      fill_in("Ingredient ID", with: "#{garlic.id}")
      click_button("Submit")

      expect(current_path).to eq("/recipes/#{good_pasta.id}")
      expect(page).to have_content(garlic.name)
    end
  end
end
  
