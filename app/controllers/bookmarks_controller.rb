class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    # id = params[:bookmark][:movie]
    movie_id_array = params[:bookmark][:movie]
    comment = bookmark_params[:comment]
    movie_id_array.each do |movie_id|
      @bookmark = Bookmark.new(comment: comment, movie_id: movie_id)
      @bookmark.list = List.find(params[:list_id])
      @bookmark.save
    end
    redirect_to list_path(params[:list_id])
    # if
    # else
    #   render :new, status: :unprocessable_entity
    # end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list_id), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
