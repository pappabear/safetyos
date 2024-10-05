class PlaceholdersController < ApplicationController
  before_action :set_placeholder, only: [:show, :edit, :update, :destroy]
  before_action :set_job
  before_action :set_step

  # GET /placeholders
  def index
    @pagy, @placeholders = pagy(Placeholder.where(step_id: @step.id).sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @placeholders
  end

  # GET /placeholders/1 or /placeholders/1.json
  def show
  end

  # GET /placeholders/new
  def new
    @placeholder = Placeholder.new

    # Uncomment to authorize with Pundit
    # authorize @placeholder
  end

  # GET /placeholders/1/edit
  def edit
  end

  # POST /placeholders or /placeholders.json
  def create
    @placeholder = Placeholder.new(placeholder_params)

    # Uncomment to authorize with Pundit
    # authorize @placeholder

    respond_to do |format|
      if @placeholder.save
        format.html { redirect_to @placeholder, notice: "Placeholder was successfully created." }
        format.json { render :show, status: :created, location: @placeholder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @placeholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /placeholders/1 or /placeholders/1.json
  def update
    respond_to do |format|
      if @placeholder.update(placeholder_params)
        format.html { redirect_to @placeholder, notice: "Placeholder was successfully updated." }
        format.json { render :show, status: :ok, location: @placeholder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @placeholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /placeholders/1 or /placeholders/1.json
  def destroy
    @placeholder.destroy!
    respond_to do |format|
      format.html { redirect_to placeholders_url, status: :see_other, notice: "Placeholder was successfully destroyed." }
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

  def set_placeholder
    @placeholder = Placeholder.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @placeholder
  rescue ActiveRecord::RecordNotFound
    redirect_to placeholders_path
  end

  # Only allow a list of trusted parameters through.
  def placeholder_params
    params.require(:placeholder).permit(:account_id, :step_id, :name)

    # Uncomment to use Pundit permitted attributes
    # params.require(:placeholder).permit(policy(@placeholder).permitted_attributes)
  end
end
