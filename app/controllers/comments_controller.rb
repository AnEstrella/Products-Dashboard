class CommentsController < ApplicationController

  def create
  	@comment = Comment.new(comment_params)
  	@save_comment = @comment.save
  	@selected_product = Product.find(comment_params[:product_id])  
  	@product_comments = Comment.where("product_id = #{comment_params[:product_id]}")	
  	render 'products/show'
  end

  def index
  	@comments = Comment.joins(:product).select("comments.*, products.name")
  end

private
  def comment_params
    params.require(:comment).permit(:comment, :product_id)
  end

end
