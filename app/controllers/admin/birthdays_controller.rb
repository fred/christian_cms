class Admin::BirthdaysController < Admin::BaseController
  
  def index
    if params[:sort]
      order = case params[:sort]
        when "first_name" then "first_name ASC, last_name ASC, month(birthdate) ASC, day(birthdate) ASC"
        when "last_name"  then "last_name ASC, first_name ASC, month(birthdate) ASC, day(birthdate) ASC"
        when "birthdate"  then "month(birthdate) ASC, day(birthdate) ASC, last_name ASC, first_name ASC"
      end
    else
      order = "month(birthdate) ASC, day(birthdate) ASC"
    end
    per_page = 36
    current_page = (params[:page] ||= 1).to_i
    
    if params[:month]
      @birthdays = Birthday.get_by_month(params[:month])
    else
      @birthdays = Birthday.paginate :page => current_page, :per_page => per_page, :order => order
    end
  end
  
  def new
    @birthday = Birthday.new
  end
  
  def create
    @birthday = Birthday.new(params[:birthday])
    if @birthday.save
      flash[:notice] = 'Cumpleanos Creado con Suceso'
      redirect_to :action => "index"
    else
      render :action => 'new'
    end
  end
  
  def edit
    @birthday = Birthday.find(params[:id])
  end

  def update
    @birthday = Birthday.find(params[:id])
    if @birthday.update_attributes(params[:birthday])
      flash[:notice] = "El cumpleanos de #{@birthday.first_name} fue actualizado con sucesso."
      #redirect_to birthdays_path
      redirect_to :action => "index"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @birthday = Birthday.find(params[:id])
    month = @birthday.birthdate.month
    @birthday.destroy
    flash[:notice] = "Cumpleaño Deletado"
    redirect_to :action => "index"
  end
  
  def import
      FasterCSV.foreach("/home/fred/cumple.csv") do |row|
        # Mes,Nombre,Apellido,Dia,Fecha,Ninos
        date = Time.parse("2000-#{row[0]}-#{row[3]}")
         
        Birthday.create :first_name => row[1],
          :last_name  => row[2],
          :birthdate   => date
    end
  end
  
end
