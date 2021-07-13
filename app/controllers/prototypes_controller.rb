class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_var, only: [:show,:edit,:update,:destroy]
  before_action :page_permit, only: [:edit, :update, :destroy]
  
  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_form)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit
    
  end

  def update
    
    if @prototype.update(prototype_form)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def destroy
    
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def prototype_form
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_var
    @prototype = Prototype.find(params[:id])
  end

  def page_permit
    redirect_to root_path unless current_user == @prototype.user
  end
end
