crumb :root do
  link "メルカリ", root_path
end

# マイページ
crumb :mypages do
  link "マイページ", mypage_path
end

# プロフィール
crumb :profile do
  link "プロフィール", edit_mypage_path
  parent :mypages
end

# 本人情報の登録
crumb :identification do
  link "本人情報の登録", edit_identification_mypage_path
  parent :mypages
end

# カテゴリー一覧
crumb :categories do
  link "カテゴリー一覧", categories_path
  parent :root
end

# 親カテゴリー
crumb :parentCategory do |category|
  link category.root.name, category_path(category.root.id)
  parent :categories
end

# 子カテゴリー
crumb :childCategory do |category|
  if category.has_parent? && category.has_children? then
    # currentCategoryが子のとき
    link category.name, category_path(category.id)
    parent :parentCategory, category
  else
    # currentCategoryが親・孫のとき
    if category.parent.blank? then
      # currentCategoryが親のとき
      parent :parentCategory, category
    else
      # currentCategoryが孫のとき
      link category.parent.name, category_path(category.parent.id)
      parent :parentCategory, category
    end
  end
end

# 孫カテゴリー
crumb :grandChildCategory do |category|
  if category.has_parent? && category.has_children? then
    # currentCategoryが子のとき
    parent :childCategory, category
  else
    # currentCategoryが親・孫のとき
    if category.children.blank? then
      # currentCategoryが孫のとき
      link category.name, category_path(category.id)
      parent :childCategory, category
    else
      parent :childCategory, category
    end
  end
end
