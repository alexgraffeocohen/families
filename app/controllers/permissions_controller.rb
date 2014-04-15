class PermissionsController < ApplicationController
  include Permissable
  before_action :set_resource

  def group
    @ids = get_people(params[:permissions])
    render 'group.js'
  end

  def individual
    @ids = get_relations(params[:permissions])
    render 'individual.js'
  end

  private
  def set_resource
    @resources = ["albums", "conversations", "events"]
    @split_url = request.referrer.split("/")
    @resource = (@split_url & @resources).first.chop
  end
end