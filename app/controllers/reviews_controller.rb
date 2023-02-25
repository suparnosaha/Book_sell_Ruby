class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  #before_action :authenticate_user!
  load_and_authorize_resource

  # GET /reviews or /reviews.json
  def index
    if params[:search].blank? && params[:search1].blank? && params[:user_id].blank?
      @reviews= Review.all
    elsif !params[:user_id].blank?
      @reviews = Review.where("user_id = ?", params[:user_id])
    else
      @reviews = search
    end
    # if @book.nil?
    #   @book = Book.find(params[:book_id])
    # end
    # if @user.nil?
    #   @user = User.find(params[:book_id])
    # end
  end

  def calculate_rating(book_id)
    @book = Book.find(book_id)

    if !@book.nil?
      @reviews = Review.where(book_id: book_id)
      @book.average_rating = 0
      count = 0
      @reviews.each do |review|
        @book.average_rating += review.rating
        count += 1
      end
      if count == 0
        @book.average_rating = 0
      else
        @book.average_rating = (@book.average_rating / count).round(1)
      end
      @book.save
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    # if @book.nil?
    #   @book = Book.find(params[:book_id])
    # end
  end

  # GET /reviews/new
  def new
    @review = Review.new
    if @book.nil?
      @book = Book.find(params[:book_id])
    end
  end

  # GET /reviews/1/edit
  def edit
    @book = Book.find(@review.book_id)
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    @book = Book.find(params[:review][:book_id])
    @review.user = current_user
    @review.book = @book

    respond_to do |format|
      if @review.save
        calculate_rating(@review.book_id)

        format.html { redirect_to reviews_path(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def search
    if(params[:search].blank?)
      #@parameter1 = params[:search].downcase
      @parameter2 = params[:search1].downcase
      #@matchBookName = Book.where("lower(name) LIKE ?", "%#{@parameter}%")
      @matchUserName = User.where("lower(username) LIKE ?", @parameter2).first
      # @matchUserName = User.find_by_username(@parameter2)
      if(@matchUserName.nil? == false)
        @matchReviews=Review.where("user_id = ?",@matchUserName.id)
      end
      # ("username LIKE ?", "%#{@parameters}%")
    else
      @parameter1 = params[:search]
      #@parameter2 = params[:search1].downcase
      @matchBookName = Book.where("lower(name) LIKE ?", @parameter1).first
      # @matchBookName = Book.find_by_name(@parameter1)
      #puts (@match)
      if(@matchBookName.nil? == false)
        @matchReviews=Review.where("book_id = ?",@matchBookName.id)

      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        calculate_rating(@review.book_id)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    book_id = @review.book_id
    @review.destroy
    calculate_rating(book_id)

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:rating, :review, :book_id)
  end
end