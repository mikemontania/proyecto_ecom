class ProductReflex < StimulusReflex::Reflex

  def change_presentation
    product_id = @element.dataset['product_id']
    presentation_id = @element.dataset['presentation_id']
    variety_id = @element.dataset['variety_id']
    internal_code = @element.dataset['internal_code']

    @product = InternalProduct.where(product_id: product_id)
                              .where(variety_id: variety_id)
                              .where(presentation_id: presentation_id)
                              .where(active: true)
                              .first

    @product ||= InternalProduct.where(product_id: product_id)
                                .where(presentation_id: presentation_id)
                                .where(active: true)
                                .first
  end

  def change_variety
    product_id = @element.dataset['product_id']
    presentation_id = @element.dataset['presentation_id']
    variety_id = @element.dataset['variety_id']
    internal_code = @element.dataset['internal_code']

    @product = InternalProduct.where(product_id: product_id)
                              .where(variety_id: variety_id)
                              .where(presentation_id: presentation_id)
                              .where(active: true)
                              .first

    @product ||= InternalProduct.where(product_id: product_id)
                                .where(presentation_id: presentation_id)
                                .where(active: true)
                                .first
  end
end
