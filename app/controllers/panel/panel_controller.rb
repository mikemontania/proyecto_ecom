class Panel::PanelController < ApplicationController
  include Pagy::Backend #Pagination

  before_action :authenticate_panel_admin!
  layout 'panel/panel_layout'

end
