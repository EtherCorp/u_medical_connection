class JsonsController < ApplicationController
  def index
    @jsons = Json.all
  end

  def create
    @json = Json.new(json_params)

    if @json.save
      ReportWorker.perform_async(@json.token, @json.medical_center, @json.title, @json.body)
      render json: { status: 'SUCCESS', message: 'Loaded json from medical center', data: @json }, status: :ok
    else
      render json: { status: 'ERROR', message: 'Json not saved', data: @json.errors }, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
private
  def json_params
    params.require(:json).permit(:token, :medical_center, :title, :body)
  end
end
