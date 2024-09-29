class GuidesController < ApplicationController
  before_action :set_guide, only: [:show, :edit, :update, :destroy]
  before_action :set_job
  before_action :set_step

  # GET /guides
  def index
    @pagy, @guides = pagy(Guide.where(step_id: @step.id).sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @guides
  end

  # GET /guides/1 or /guides/1.json
  def show
  end

  # GET /guides/new
  def new
    @guide = Guide.new

    # Uncomment to authorize with Pundit
    # authorize @guide
  end

  # GET /guides/1/edit
  def edit
  end

  # POST /guides or /guides.json
  def create
    @guide = Guide.new(guide_params)
    @guide.step_id = params[:step_id]

    # Uncomment to authorize with Pundit
    # authorize @guide

    respond_to do |format|
      if @guide.save
        format.html { redirect_to job_step_guides_path(@job, @step), notice: "Guide was successfully created." }
        format.json { render :show, status: :created, location: @guide }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /guides/1 or /guides/1.json
  def update
    respond_to do |format|
      if @guide.update(guide_params)
        format.html { redirect_to job_step_guides_path(@job, @step), notice: "Guide was successfully updated." }
        format.json { render :show, status: :ok, location: @guide }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @guide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guides/1 or /guides/1.json
  def destroy
    @guide.destroy!
    respond_to do |format|
      format.html { redirect_to job_step_guides_path(@job, @step), status: :see_other, notice: "Guide was successfully destroyed." }
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

  def set_guide
    @guide = Guide.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @guide
  rescue ActiveRecord::RecordNotFound
    redirect_to guides_path
  end

  # Only allow a list of trusted parameters through.
  def guide_params
    params.require(:guide).permit(:account_id, :step_id, :name, :description, :doc)

    # Uncomment to use Pundit permitted attributes
    # params.require(:guide).permit(policy(@guide).permitted_attributes)
  end
end
