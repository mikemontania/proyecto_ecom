const { Category, Subcategory, InternalProduct, Product, Presentation, Variety, Brand } = require('../models');
const { Op } = require('sequelize');

async function list(_req, res) {
  const categories = await Category.findAll({ order: [['display_order', 'ASC'], ['name_es', 'ASC']] });
  const shaped = categories.map(c => ({
    id: c.id,
    name: c.name_es,
    slug: c.slug,
    description: c.description,
    image_url: c.image_url,
    display_order: c.display_order,
    active: c.active,
  }));
  res.json(shaped);
}

async function show(req, res) {
  // Mirrors Rails CategoriesController#show
  const { slug } = req.params;
  const category = await Category.findOne({ where: { slug } });
  if (!category) return res.status(404).json({ message: 'Category not found' });

  const products = await InternalProduct.findAll({
    include: [
      { model: Product, required: true, where: { active: true } },
      { model: Variety, required: true },
      { model: Presentation, required: true },
    ],
    where: { active: true, price: { [Op.gt]: 0 } },
    order: [
      ['featured', 'DESC'],
      [Product, 'order', 'ASC'],
      [Variety, 'name_es', 'ASC'],
      [Presentation, 'size', 'ASC'],
    ],
  });

  const brands = await Brand.findAll({ where: { active: true, id: { [Op.in]: category && (await Product.findAll({ attributes: ['brand_id'], where: { category_id: category.id } })).map(p => p.brand_id) } } });
  const subcategories = await Subcategory.findAll({ where: { category_id: category.id, active: true } });

  const shapedCategory = {
    id: category.id,
    name: category.name_es,
    slug: category.slug,
    description: category.description,
    image_url: category.image_url,
    display_order: category.display_order,
    active: category.active,
  };

  res.json({ category: shapedCategory, products, brands, subcategories });
}

module.exports = { list, show };
