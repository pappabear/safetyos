class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :set_job
  before_action :set_step

  # GET /todos
  def index
    @pagy, @todos = pagy(Todo.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @todos
  end

  # GET /todos/1 or /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new

    # Uncomment to authorize with Pundit
    # authorize @todo
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos or /todos.json
  def create
    @todo = Todo.new(todo_params)

    # Uncomment to authorize with Pundit
    # authorize @todo

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: "Todo was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1 or /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: "Todo was successfully updated." }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1 or /todos/1.json
  def destroy
    @todo.destroy!
    respond_to do |format|
      format.html { redirect_to todos_url, status: :see_other, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:job_id])
  end

  def set_step
    @step = Step.find(params[:step_id])
  end

  def set_todo
    @todo = Todo.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @todo
  rescue ActiveRecord::RecordNotFound
    redirect_to todos_path
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:account_id, :step_id, :name, :sequence, :todo_status_id, :description, :notes)

    # Uncomment to use Pundit permitted attributes
    # params.require(:todo).permit(policy(@todo).permitted_attributes)
  end
end
