class Api::V1::TransactionsController < Api::V1::BaseController
  before_action :set_transaction, only: %i[ show update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = @current_family.transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params.except(:receipt))
    @transaction.family = @current_family
    @transaction.user = current_user

    if transaction_params[:receipt].present?
      decoded_data = Base64.decode64(transaction_params[:receipt].split(',')[1])
      @transaction.receipt = {
        io: StringIO.new(decoded_data),
        content_type: 'image/jpeg',
        filename: 'receipt.jpg'
      }
    end

    respond_to do |format|
      if @transaction.save
        format.json { render :show, status: :created, location: @transaction }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
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
      params.require(:transaction).permit(:transaction_date, :amount, :category_id, :receipt, :description)
    end
end
