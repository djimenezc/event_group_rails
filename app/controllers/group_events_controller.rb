class GroupEventsController < ApplicationController
  before_action :set_group_event, only: [:show, :edit, :update, :delete, :publish]

  # GET /group_events
  # GET /group_events.json
  def index
    @group_events = GroupEvent.where :deleted => false
  end

  # GET /group_events/1
  # GET /group_events/1.json
  def show
    @group_event = GroupEvent.find params[:id]

    respond_to do |format|
      format.html { render :new }
      format.json { render json: @group_event }
    end
  end

  # GET /group_events/new
  def new
    @group_event = GroupEvent.new
  end

  # GET /group_events/1/edit
  def edit
    @group_event = GroupEvent.find params[:id]
  end

  # POST /group_events
  # POST /group_events.json
  def create
    @group_event = GroupEvent.new(group_event_params)

    respond_to do |format|
      if @group_event.save
        format.html { redirect_to @group_event, notice: 'Group event was successfully created.' }
        format.json { render :show, status: :created, location: @group_event }
      else
        format.html { render :new }
        format.json { render json: @group_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_events/1
  # PATCH/PUT /group_events/1.json
  def update
    respond_to do |format|
      if @group_event.update(group_event_params)
        format.html { redirect_to @group_event, notice: 'Group event was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_event }
      else
        format.html { render :edit }
        format.json { render json: @group_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_events/1
  # DELETE /group_events/1.json
  def delete
    # @group_event.destroy
    @group_event = GroupEvent.find params[:id]

    @group_event.deleted = true
    @group_event.save!

    respond_to do |format|
      format.html { redirect_to group_events_url, notice: 'Group event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /group_events/1/publish
  # GET /group_events/1/publish.json
  def publish

    @group_event.published = true

    begin
      @group_event.save!
    rescue Exception => ex
      respond_to do |format|
        format.json { render :json => {:errors => @group_event.errors.full_messages}, :status => 422 }
        format.html { redirect_to group_events_url, notice: ex.message }
      end
    else
      respond_to do |format|
        format.html { redirect_to group_events_url, notice: 'Group event was successfully published.' }
        format.json { head :no_content }
      end
    end

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group_event
    @group_event = GroupEvent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_event_params
    params.require(:group_event).permit(:name, :location, :description, :start_date, :duration, :deleted, :published)
  end
end
