class CategoriesController < ApplicationController
  before_action :set_category_list,only:[:show]

  def index
    @parents = Category.all.where(ancestry: nil).limit(12);
  end

  def new
  end

  def show
    @category = Category.find(params[:id])
    # 親カテゴリーの場合
    # if @category.is_root?
    #   @category_list     = @category. # 子カテゴリーを9件＆孫カテゴリーを2件取得
    #   @category_items    = Item.category_items(@category.indirects).order('created_at DESC');
    #   @category_message1 = category_message(@category.id, @category.name);
    # # 子カテゴリーの場合
    # elsif @category.has_children?
    #   @category_list     = @category.children.rand_recent(9) | @category.siblings.rand_recent(2) # ランダムで孫カテゴリーを9件＆兄弟カテゴリーを2件取得
    #   @category_items    = Item.category_items(@category.children).order('created_at DESC');
    #   @category_message1 = category_message(@category.parent.id, @category.name);
    # # 孫カテゴリーの場合
    # else
    #   @category_list     = @category.siblings.rand_recent(11) # ランダムで兄弟カテゴリーを11件取得
    #   @category_items    = Item.category_item(@category).order('created_at DESC');
    #   @category_message1 = category_message(@category.root_id, @category.name);
    # end
    # # カテゴリーごとの共通メッセージ
    # @category_message2 = "#{@category.name}の商品は#{category_count(@category_items)}点以上あります。"
  end

  def edit
  end

  def destroy
  end

  # private
  # def set_category_list
  #   @Category = Category.find(params[:id])
  # end
end
# @Category = Category.find(params[:id])
