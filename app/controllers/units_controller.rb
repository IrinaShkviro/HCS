class UnitsController < ApplicationController
   def new
      @unit = Unit.new
   end

   def index
      @units = Unit.all
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

#   def findUnit
      #if (Unit.where(surname: s.surname, homework: t.homework, number: t.number).take.state.exists?)
       #  @unit = Unit.where(surname: s.surname, homework: t.homework, number: t.number).take.statenit
      #else 
       #  @unit = Unit.new(
#   end

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
          params.require(:unit).permit(:surname, :state, :homework, :number, :comment, :time)
      end
end
