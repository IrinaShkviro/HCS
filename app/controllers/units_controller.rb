class UnitsController < ApplicationController
   helper_method :findUnit
   helper_method :findUnitState
   def new
      @unit = Unit.new
   end

   def index
      @units = Unit.all
   end

   def show
   end

   def create
      @unit = Unit.new(unit_params)

      if @unit.save
          redirect_to @unit
      else
          render 'new'
      end
   end

   def edit
      @unit = Unit.find(params[:id])
   end

   def self.findUnit(searched_email, searched_homework, searched_number)
	if (Unit.where(email: searched_email, homework: searched_homework, number: searched_number).take)
       		return Unit.where(email: searched_email, homework: searched_homework, number: searched_number).take
	else 
		return ''
	end
   end

   def self.findUnitState(searched_email, searched_homework, searched_number)
	if (Unit.where(email: searched_email, homework: searched_homework, number: searched_number).take)
       		return Unit.where(email: searched_email, homework: searched_homework, number: searched_number).take.state
	else 
		return ''
	end
   end

   def destroy
       @unit = Unit.find(params[:id])
       @unit.destroy
       system "rake environment tire:import CLASS=Unit FORCE=true"
        redirect_to units_path
   end

   def update
       @unit = Unit.find(params[:id])
 
       if @unit.update(unit_params)
           redirect_to @unit
       else
           render 'edit'
       end
   end

   private
      def unit_params
          params.require(:unit).permit(:email, :state, :homework, :number, :comment)
      end
end
