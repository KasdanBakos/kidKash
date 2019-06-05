class ParentChildrenController < ApplicationController
  before_action :set_parent_child, only: [:show, :edit, :update, :destroy]

  # GET /parent_children
  # GET /parent_children.json
  def index
    @parent_children = ParentChild.all
  end

  # GET /parent_children/1
  # GET /parent_children/1.json
  def show
  end

  # GET /parent_children/new
  def new
    @parent_child = ParentChild.new
  end

  # GET /parent_children/1/edit
  def edit
  end

  # POST /parent_children
  # POST /parent_children.json
  def create
    @parent_child = ParentChild.new(parent_child_params)

    respond_to do |format|
      if @parent_child.save
        format.html { redirect_to @parent_child, notice: 'Parent child was successfully created.' }
        format.json { render :show, status: :created, location: @parent_child }
      else
        format.html { render :new }
        format.json { render json: @parent_child.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parent_children/1
  # PATCH/PUT /parent_children/1.json
  def update
    respond_to do |format|
      if @parent_child.update(parent_child_params)
        format.html { redirect_to @parent_child, notice: 'Parent child was successfully updated.' }
        format.json { render :show, status: :ok, location: @parent_child }
      else
        format.html { render :edit }
        format.json { render json: @parent_child.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parent_children/1
  # DELETE /parent_children/1.json
  def destroy
    @parent_child.destroy
    respond_to do |format|
      format.html { redirect_to parent_children_url, notice: 'Parent child was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent_child
      @parent_child = ParentChild.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_child_params
      params.require(:parent_child).permit(:parent_id, :child_id)
    end
end
