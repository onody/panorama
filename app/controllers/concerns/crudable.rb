module CRUDable
  extend ActiveSupport::Concern

  included do
    before_action :set_model
    before_action :set_resource, only: [:edit, :update, :destroy]

    def index
      instance_variable_set :"@#{model_name.tableize}", @model.page(params[:page])
    end
    
    def show
    end

    def new
      instance_variable_set :"@#{model_name.underscore}", @model.new
    end

    def edit
    end

    def create
      instance_variable_set :"@#{model_name.underscore}", @model.new(resource_params)

      respond_to do |format|
        if instance_variable_get("@#{model_name.underscore}").save
          format.html { redirect_to action: :index, notice: 'Resource was successfully created.' }
          format.json { render action: 'show', status: :created, location: instance_variable_get("@#{model_name.underscore}") }
        else
          format.html { render "concerns/admin/new" }
          format.json { render json: instance_variable_get("@#{model_name.underscore}").errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if instance_variable_get("@#{model_name.underscore}").update(resource_params)
          format.html { redirect_to action: :index, notice: 'Resource was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render "concerns/admin/edit" }
          format.json { render json: instance_variable_get("@#{model_name.underscore}").errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      instance_variable_get("@#{model_name.underscore}").destroy

      respond_to do |format|
        format.html { redirect_to action: :index, notice: 'Resource was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_model
      @model = controller_name.classify.constantize
    end

    def model_name
      @model.to_s
    end

    def set_resource
      instance_variable_set :"@#{model_name.underscore}", @model.find(params[:id])
    end

    def resource_params
      params.require(model_name.underscore.intern).permit(*@model.column_names.map(&:intern))
    end
  end
end
