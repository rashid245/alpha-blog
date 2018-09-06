class ArticlesController < ApplicationController
    
    def index
        @articles = Article.all
    end
    
    def new
        @article = Article.new
    end
    
    def edit
        if Article.exists?(id: params[:id] )
            @article = Article.find(params[:id])
        else
            flash[:notice] = "Article not found"
            redirect_to article_new
        end
    end
    
    def update
        @article = Article.find(params[:id])
        
        if @article.update(  article_params )
            flash[:notice] = "Article was successfully updated.."
            redirect_to article_path(@article)
        else
            flash[:notice] = "Update has failed"
            render 'edit'
        end
    end
    
    def create
        @article = Article.new(article_params)
        
        if @article.save
            flash[:notice] = "Article successfully created"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end
    
    def show
        if Article.exists?(id: params[:id] )
            @article = Article.find(params[:id])
        else
            flash[:notice] = "Article not found"
            redirect_to new_article_path
        end
    end
    
    def destroy
        @article = Article.find(params[:id])
        
        if @article.destroy
            flash[:notice] = "Article has been successfully deleted"
            redirect_to articles_path
        else
            flash[:notice] = "Removal of article has failed"
            redirect_to articles_path
        end
    end
    
    private 
        def article_params
            params.require(:article).permit(:title, :description)
        end
        
    
end