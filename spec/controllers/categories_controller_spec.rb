require 'rails_helper'

describe CategoriesController do
  let!(:items) {create_list(:item, 10)}
  let!(:categories) {create_list(:category, 10)}

  describe 'GET #index' do

    before do
      get :index
    end

    it "assigns @parentCategories" do
      expect(assigns(:parentCategories)).to match(Category.where(ancestry: nil))
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end

  end

  describe 'GET #show' do

    before do
      get :show, params: {id: categories[0].id}
    end

    it "assigns @parentCategories" do
      expect(assigns(:parentCategories)).to match(Category.where(ancestry: nil))
    end
    # 未テスト
    # it "assigns @items" do
    #   if Category.find(categories[0].id).has_children? then
    #     binding.pry
    #     expect(assigns(:items)).to match(Item.where(category_id: [2, 21, 43, 56, 62, 67, 78, 87, 95, 114, 201, 214, 238, 248, 257, 270, 276, 284, 293, 323, 681, 692, 698, 707, 722, 731, 747, 754, 758, 769, 894, 900, 909, 918, 926, 935, 944, 951, 965, 977, 1089, 1099, 1106, 1111, 1119, 1123, 1129, 1134, 1137, 1090]).sort{|a, b| b.id <=> a.id}.values_at(0..5))
    #   else
    #     expect(assigns(:items)).to match(Item.where(category_id: [2, 21, 43, 56, 62, 67, 78, 87, 95, 114, 201, 214, 238, 248, 257, 270, 276, 284, 293, 323, 681, 692, 698, 707, 722, 731, 747, 754, 758, 769, 894, 900, 909, 918, 926, 935, 944, 951, 965, 977, 1089, 1099, 1106, 1111, 1119, 1123, 1129, 1134, 1137, 1090]).sort{|a, b| b.id <=> a.id}.values_at(0..5))
    #   end
    # end
    it "assigns @category" do
      expect(assigns(:category)).to match(Category.find(categories[0].id))
    end

    it "renders the :show template" do
      expect(response).to render_template :show
    end

  end

end