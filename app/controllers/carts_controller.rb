class CartsController < ApplicationController
  before_action :authorized, :set_cart, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /carts or /carts.json
  def index
    @carts = Cart.where(user_id: current_user.id, transaction_id: nil)
  end

  # GET /carts/1 or /carts/1.json
  def show
  end

  def check
    @cart = Cart.where(user_id: current_user.id, book_id: params[:book_id], transaction_id: nil).first

    if @cart
      redirect_to edit_cart_path(@cart)
    else
      redirect_to new_cart_path(:book_id => params[:book_id])
    end

  end

  # GET /carts/new
  def new
    @cart = Cart.new
    if @book.nil?
      @book = Book.find(params[:book_id])
    end
    @submit_text = 'Create Item'
  end

  # GET /carts/1/edit
  def edit
    @book = Book.find(@cart.book_id)
    @submit_text = 'Update Item'
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(cart_params)
    @book = Book.find(params[:cart][:book_id])
    @cart.user = current_user
    @cart.book = @book
    @book.save

    respond_to do |format|
      if @cart.save
        format.html { redirect_to cart_path(@cart), notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @cart }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to cart_path(@cart), notice: "Item was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to carts_path, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:quantity, :total_cost)
    end
end
