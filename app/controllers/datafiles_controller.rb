class DatafilesController < ApplicationController
   def new
      @datafile = Datafile.new
   end

   def create
      uploaded_io = params[:datafile][:dfile]
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
          file.write(uploaded_io.read)
          end
   end

   def index
      @datafiles = Datafile.all
   end

   def upload
      uploaded_io = params[:datafile][:dfile]
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      		file.write(uploaded_io.read)
  	 end
   end

   private
      def datafile_params
          params.require(:datafile).permit(:name, :comment, :time, :size)
      end
end
