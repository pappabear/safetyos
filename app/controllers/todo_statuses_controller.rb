class TodoStatusesController < ApplicationController
  before_action :set_todo_status, only: [:show, :edit, :update, :destroy]

  # GET /todo_statuses
  def index
    @pagy, @todo_statuses = pagy(TodoStatus.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @todo_statuses
  end

  # GET /todo_statuses/1 or /todo_statuses/1.json
  def show
  end

  # GET /todo_statuses/new
  def new
    @todo_status = TodoStatus.new

    # Uncomment to authorize with Pundit
    # authorize @todo_status
  end

  # GET /todo_statuses/1/edit
  def edit
  end

  # POST /todo_statuses or /todo_statuses.json
  def create
    @todo_status = TodoStatus.new(todo_status_params)

    # Uncomment to authorize with Pundit
    # authorize @todo_status

    respond_to do |format|
      if @todo_status.save
        format.html { redirect_to @todo_status, notice: "Todo status was successfully created." }
        format.json { render :show, status: :created, location: @todo_status }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_statuses/1 or /todo_statuses/1.json
  def update
    respond_to do |format|
      if @todo_status.update(todo_status_params)
        format.html { redirect_to @todo_status, notice: "Todo status was successfully updated." }
        format.json { render :show, status: :ok, location: @todo_status }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_statuses/1 or /todo_statuses/1.json
  def destroy
    @todo_status.destroy!
    respond_to do |format|
      format.html { redirect_to todo_statuses_url, status: :see_other, notice: "Todo status was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo_status
    @todo_status = TodoStatus.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @todo_status
  rescue ActiveRecord::RecordNotFound
    redirect_to todo_statuses_path
  end

  # Only allow a list of trusted parameters through.
  def todo_status_params
    params.require(:todo_status).permit(:name)

    # Uncomment to use Pundit permitted attributes
    # params.require(:todo_status).permit(policy(@todo_status).permitted_attributes)
  end
end
