class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by(email: params[:email])

    @collaborator = Collaborator.create(wiki_id: @wiki.id, user_id: @user.id)
    
    if @collaborator.save
      redirect_to wiki_path(@wiki), notice: "#{@user.name} ahora es colaborador."
    end
  end

  def destroy
  end
end