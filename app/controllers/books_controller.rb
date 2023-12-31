class BooksController < ApplicationController
  # アクセス制限
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    # @user = User.find(current_user.id)
    @user = @books.user
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  # ストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :profile_image, :body)
  end

  # アクセス制限
  def is_matching_login_user
    # book = Book.find(params[:id]).user
    book = Book.find(params[:id])
    books = book.user
    unless books.id == current_user.id
      redirect_to books_path
    end
  end
end
