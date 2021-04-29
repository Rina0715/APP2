class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @new_book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
    render "edit"
    else
      redirect_to books_path
    end
  end


  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "Book was successfully destroyed."
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "Book was successfully updated."
       redirect_to book_path(@book.id)
    else
      render :edit
    end
  end
  def create
    @user = current_user
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@new_book)
    else
      @books = Book.all
      render :index
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end


end
