class WikisController < ApplicationController
  require 'will_paginate/array'

  def index
    @scoped_wikis = policy_scope(Wiki)
    @scoped_tagged_wikis = policy_scope(Wiki.tagged_with(params[:tag]))
    if params[:tag]
      @wikis = @scoped_tagged_wikis.paginate(page: params[:page], per_page: 25)
    else
      @wikis = @scoped_wikis.paginate(page: params[:page], per_page: 50)
    end
  end

  def privates
    @scoped_wikis = Wiki.visible_to_premium(current_user)
    @wikis = @scoped_wikis.paginate(page: params[:page], per_page: 35)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.new(wiki_params)
    authorize @wiki
     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :new
     end
  end

  def edit
    @collaborator = Collaborator.new
    @wiki = Wiki.find(params[:id])
    @collaborators = @wiki.collaborators
    @users = User.all
  end

  def update
     @wiki = Wiki.find(params[:id])
     
     if @wiki.update_attributes(wiki_params)
       flash[:notice] = "Wiki was updated."
       redirect_to @wiki
     else
       flash[:error] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end


  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "Wiki was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :tag_list)
  end
end
