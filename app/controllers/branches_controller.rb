class BranchesController < ApplicationController
  def index
    @branches = Branches.where(active: true)
  end

  def show
    @branch = Branch.friendly.find(params[:id])
  end
end
