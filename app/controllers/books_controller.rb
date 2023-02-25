class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /books or /books.json
  def index
    if params[:name].blank? && params[:author].blank? && params[:rating].blank?
      @books = Book.all
    else
      @books = search
    end
  end

  def search
    puts("ENTERED SEARCH")
    if(!params[:name].blank?)
      @name = params[:name].downcase
      @match = Book.where("lower(name) LIKE ?",@name)
    elsif(!params[:author].blank?)
      @author = params[:author].downcase
      @match = Book.where("lower(author) LIKE ?",@author)
    else
      @rating = params[:rating]
      puts("RATING")
      puts(@rating)
      @match = Book.where('average_rating >= ?', @rating)
      end
    end
  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)
    @book.average_rating = 0
    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :author, :publisher, :price, :stock, :average_rating)
    end
end
