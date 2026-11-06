class CyclesController < ApplicationController
  before_action :set_cycle, only: %i[ show edit update destroy ]

  def index
    @cycles = Cycle.ordered
  end

  def show
    @year = Year.find params[:year_id] if params.has_key?(:year_id)
  end

  def new
    @cycle = Cycle.new
  end

  def edit
  end

  def create
    @cycle = Cycle.new(cycle_params)
    if @cycle.save
      redirect_to @cycle, notice: "Cycle was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @cycle.update(cycle_params)
      redirect_to @cycle, notice: "Cycle was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @cycle.destroy!
    redirect_to cycles_path, notice: "Cycle was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cycle
      @cycle = Cycle.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def cycle_params
      params.expect(cycle: [ :name, :code, :started_at, :ended_at, :description ])
    end
end
