require 'fileutils'

class DatafilesController < ApplicationController
  before_action :set_datafile, only: [:show, :edit, :update, :destroy]

  # GET /datafiles
  # GET /datafiles.json
  def index
    @datafiles = Datafile.all
  end

  # GET /datafiles/1
  # GET /datafiles/1.json
  def show
  end

  # GET /datafiles/new
  def new
    @datafile = Datafile.new
  end

  # GET /datafiles/1/edit
  def edit
  end

  # POST /datafiles
  # POST /datafiles.json
  def create

    @datafile = Datafile.new(dataset_id: params[:datafile][:dataset_id])
    uploaded_io = params[:datafile][:upload]

    @datafile.web_id ||= @datafile.generate_web_id

    @datafile.storage_root = Application.storage_manager.draft_root
    @datafile.filename = uploaded_io.original_filename
    @datafile.storage_key = File.join(@datafile.web_id, @datafile.filename)
    @datafile.size = uploaded_io.size

    # Moving the file to some safe place; as tmp files will be flushed timely
    Application.storage_manager.draft_root.copy_io_to(@datafile.storage_key, uploaded_io, nil, uploaded_io.size)

    respond_to do |format|
      if @datafile.save
        format.html { redirect_to @datafile, notice: 'Datafile was successfully created.' }
        format.json { render :show, status: :created, location: @datafile }
      else
        format.html { render :new }
        format.json { render json: @datafile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datafiles/1
  # PATCH/PUT /datafiles/1.json
  def update
    respond_to do |format|
      if @datafile.update(datafile_params)
        format.html { redirect_to @datafile, notice: 'Datafile was successfully updated.' }
        format.json { render :show, status: :ok, location: @datafile }
      else
        format.html { render :edit }
        format.json { render json: @datafile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datafiles/1
  # DELETE /datafiles/1.json
  def destroy
    @datafile.destroy
    respond_to do |format|
      format.html { redirect_to datafiles_url, notice: 'Datafile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datafile
      @datafile = Datafile.find_by_web_id(params[:web_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datafile_params
      params.require(:datafile).permit(:dataset_id, :web_id, :upload, 'upload', :dataset_key, 'datafiles', 'datafiles'['upload'], 'datafiles'['dataset_id'])
    end
end
