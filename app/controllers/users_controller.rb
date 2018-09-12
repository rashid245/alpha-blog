class UsersController < ApplicationController
    
   def index
   end
   
   def new
       @user = User.new
   end
   
   def create
      @user = User.new(user_params)
      
      if @user.save
         flash[:success] = "Welcome to the alpha blog #{@user.username}"
         redirect_to articles_path
      else
         flash[:notice] = "Registration has failed!"
         render 'new'
      end
   end
   
   def edit
      if User.exists?(id: params[:id] )
            @user = set_user
        else
            flash[:notice] = "User does not exist"
            redirect_to articles_path
      end
   end
   
   def update
      @user = User.find(params[:id])
      if @user.update(user_params)
         flash[:success] = @user.username + ", you have successfully updated your account"   
         redirect_to articles_path
      else
         flash[:notice] = "Something went wrong"
         render 'edit'
      end
   end
   
   private 
      def user_params
         params.require(:user).permit(:username, :email, :password)
      end
      def set_user
            if User.exists?(id: params[:id] )
                @user = User.find(params[:id])
            end
      end
end