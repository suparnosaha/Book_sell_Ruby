class TransactionsController < ApplicationController
  before_action :authorized, :set_transaction, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    if @user.nil?
      @user = current_user
    end
    @carts = Cart.where(transaction_id: @transaction.id)
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @transaction.quantity = 0
    @transaction.total_price = 0

    # Find the objects present in the cart
    @carts = Cart.where(user_id: current_user.id, transaction_id: nil)
    @carts.each do |cart|
      @transaction.quantity += cart.quantity
      @transaction.total_price += cart.total_cost
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.transaction_number = Array.new(10){[ *0..9].sample}.join
    @transaction.user = current_user
    @flag = 0
    @carts = Cart.where(user_id: current_user.id, transaction_id: nil)
    @carts.each do |cart|
      @each_book=Book.find_by_id(cart.book_id)
      stock = @each_book.stock - cart.quantity
      if(stock < 0)
        @flag = 1
        cart.destroy
        # redirect_to root_path, notice: "Sorry! some of the books in your cart is out of stock" 
      end
    end
    
    respond_to do |format|
      if @transaction.save && @flag == 0
        
        @carts.each do |cart|
          @each_book=Book.find_by_id(cart.book_id)
          @each_book.stock = @each_book.stock - cart.quantity
          @each_book.save
        end
        
        @carts.each do |cart|
          cart.update(transaction_id: @transaction.id)
        end
        
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      elsif @flag == 1
        format.html {redirect_to root_path, notice: "Sorry! some of the books in your cart is out of stock"}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:credit_card_number, :address, :phone_number, :quantity, :total_price)
    end
end
