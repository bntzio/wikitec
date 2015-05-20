class VersionsController < ApplicationController
  before_action :set_wiki_and_version, only: [:diff, :rollback, :destroy]

  def diff
  end

  def rollback
    # change the current wiki to the specified version
    # reify gives you the object of this version
    wiki = @version.reify
    wiki.save
    redirect_to edit_wiki_path(wiki)
  end

  private

  def set_wiki_and_version
      @wiki = Wiki.find(params[:wiki_id])
      @version = @wiki.versions.find(params[:id])
  end
end