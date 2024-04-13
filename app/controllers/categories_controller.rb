class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      current_user.user_categories.create(category: @category)
      redirect_to mypage_path, success: '登録が完了しました'
    else
      redirect_to mypage_path, error: '登録できませんでした'
    end
  end

  def edit
    @category = Category.find(params[:id])
    render turbo_stream: turbo_stream.replace("category_#{params[:id]}", partial: "categories/edit", locals: { category: @category })
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to mypage_path, success: "カテゴリーを更新しました"
    else
      redirect_to mypage_path, error: '更新できませんでした'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    render turbo_stream: turbo_stream.remove("category_#{params[:id]}") 
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
