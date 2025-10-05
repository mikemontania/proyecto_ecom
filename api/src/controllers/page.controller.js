const { Page } = require('../models');

async function list(_req, res) {
  const items = await Page.findAll({ where: { active: true }, order: [['order', 'ASC'], ['created_at', 'DESC']] });
  res.json(items);
}

async function getBySlug(req, res) {
  const { slug } = req.params;
  const item = await Page.findOne({ where: { slug, active: true } });
  if (!item) return res.status(404).json({ message: 'Page not found' });
  res.json(item);
}

module.exports = { list, getBySlug };
