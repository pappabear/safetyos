class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy]
  before_action :set_job

  # GET /steps
  def index
    @pagy, @steps = pagy(Step.where(job_id: @job.id).sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @steps
  end

  # GET /steps/1 or /steps/1.json
  def show
  end

  # GET /steps/new
  def new
    @step = Step.new

    # Uncomment to authorize with Pundit
    # authorize @step
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps or /steps.json
  def create
    @step = Step.new(step_params)
    @step.job_id = params[:job_id]

    # Uncomment to authorize with Pundit
    # authorize @step

    respond_to do |format|
      if @step.save
        format.html { redirect_to job_step_path(@job, @step), notice: "Step was successfully created." }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1 or /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to job_step_path(@job, @step), notice: "Step was successfully updated." }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1 or /steps/1.json
  def destroy
    @step.destroy!
    respond_to do |format|
      format.html { redirect_to job_steps_url(@job), status: :see_other, notice: "Step was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_step
    @step = Step.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @step
  rescue ActiveRecord::RecordNotFound
    redirect_to steps_path
  end

  def set_job
    @job = Job.find(params[:job_id])
  end


  # Only allow a list of trusted parameters through.
  def step_params
    params.require(:step).permit(:account_id, :job_id, :name, :sequence, :notes)

    # Uncomment to use Pundit permitted attributes
    # params.require(:step).permit(policy(@step).permitted_attributes)
  end
end
