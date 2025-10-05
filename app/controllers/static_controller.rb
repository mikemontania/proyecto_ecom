class StaticController < ApplicationController
  def la_empresa; end

  def historia; end

  def quienes_somos; end

  def contacto; end

  def cobertura; end

  def export
    @representatives = Representative.all
  end
end
