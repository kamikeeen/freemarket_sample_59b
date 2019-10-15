class SearchController < ApplicationController

  before_action :set_ransack

  def index
    if params[:q][:category_id_in] && params[:q][:category_id_in] != "" && Category.find(params[:q][:category_id_in]).has_children?
      params[:q][:category_id_in] = Category.find(params[:q][:category_id_in]).descendants.ids
    end
    if params[:q][:size_id_in] && params[:q][:size_id_in].length == 1 && params[:q][:size_id_in].first != ""
      params[:q][:size_id_in] = Size.find(params[:q][:size_id_in].first).descendants.ids
    end
  end
end
