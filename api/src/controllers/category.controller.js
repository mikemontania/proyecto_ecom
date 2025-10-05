const { Category } = require('../models');

async function list(_req, res) {
  const categories = await Category.findAll({ order: [['display_order', 'ASC'], ['name', 'ASC']] });
  res.json(categories);
}

module.exports = { list };
