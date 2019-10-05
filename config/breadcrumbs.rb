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
end

# 下のカテゴリの定義
# def oya
#   parents = Category.all.where(ancestry: nil).limit(12);
#   parents.each do |parent|
#   parent.name
# end

# カテゴリの定義の参考
# crumb :show_notice do |i|
#   link "#{i.name}"さん,"/users/:id/show_notice"
#   parent :user
# end

# 親カテゴリー
crumb :parent_categories do |x|
  link "#{x.name},"/categories/:id/parent_categories"
  parent :categories.x
end

# 子カテゴリー
# crumb :Child_categories do
#   link "子カテゴリーのみを入れた変数", categories_path
#   parent :parent_categories.
# end

# 孫カテゴリー
# crumb :Grandchild_categories do
#   link "孫カテゴリーのみを入れた変数", categories_path
#   parent :Child_categories
# end



# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).