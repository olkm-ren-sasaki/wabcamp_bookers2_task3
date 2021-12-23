class BooksController < ApplicationController
 before_action :correct_user, only: [:edit]

  def index
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end


  def create
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private
  def book_params
   params.require(:book).permit(:title, :body)
  end
  def correct_user
  @book = Book.find(params[:id])
  @user = @book.user
  redirect_to(books_path) unless @user == current_user
  end


end
