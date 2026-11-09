class OperationsController < ApplicationController
  before_action :set_operation, only: %i[ show edit update destroy ]

  def index
    @operations = Operation.ordered
  end

  def show
    @year = Year.find params[:year_id] if params.has_key?(:year_id)
  end

  def new
    @operation = Operation.new
  end

  def edit
  end

  def create
    @operation = Operation.new(operation_params)
    if @operation.save
      redirect_to @operation, notice: "Operation was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @operation.update(operation_params)
      redirect_to @operation, notice: "Operation was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @operation.destroy!
    redirect_to operations_path, notice: "Operation was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.expect(operation: [ :name, :code, :started_at, :ended_at, :description ])
    end
end
