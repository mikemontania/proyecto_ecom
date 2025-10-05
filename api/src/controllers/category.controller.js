const { Category, Subcategory, InternalProduct, Product, Presentation, Variety, Brand } = require('../models');
const { Op } = require('sequelize');

async function list(_req, res) {
  const categories = await Category.findAll({ order: [['name_es', 'ASC']] });
  res.json(categories);
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

  res.json({ category, products, brands, subcategories });
}

module.exports = { list, show };
