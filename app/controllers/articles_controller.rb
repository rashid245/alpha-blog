class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    
    def index
        @articles = Article.all
    end
    
    def new
        @article = Article.new
    end
    
    def edit
        if Article.exists?(id: params[:id] )
            #@article = set_article
        else
            flash[:notice] = "Article not found"
            redirect_to articles_path
        end
    end
    
    def update
       # @article = set_article
        
        if @article.update(  article_params )
            flash[:success] = "Article was successfully updated.."
            redirect_to article_path(@article)
        else
            flash[:notice] = "Update has failed"
            render 'edit'
        end
    end
    
    def create
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save
            flash[:success] = "Article successfully created"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end
    
    def show
        if Article.exists?(id: params[:id] )
           # @article = set_article
        else
            flash[:notice] = "Article not found"
            redirect_to articles_path
        end
    end
    
    def destroy
        #@article = set_article
        
        
        if @article.destroy
            flash[:danger] = "Article has been successfully deleted"
            redirect_to articles_path
        else
            flash[:notice] = "Removal of article has failed"
            redirect_to articles_path
        end
    end
    
    private 
        def set_article
            if Article.exists?(id: params[:id] )
                @article = Article.find(params[:id])
            end
        end
        def article_params
            params.require(:article).permit(:title, :description)
        end
end