const { Op } = require('sequelize');
const Producto = require('../models/producto.model');
const Categoria = require('../models/categoria.model');
const Subcategoria = require('../models/subcategoria.model');
const Marca = require('../models/marca.model');

const list = async (req, res) => {
  try {
    const { category_slug, subcategory_slug, brand_slug, search } = req.query;
    const where = {};
    const include = [];
    if (category_slug) include.push({ model: Categoria, where: { slug: category_slug } });
    if (subcategory_slug) include.push({ model: Subcategoria, where: { slug: subcategory_slug } });
    if (brand_slug) include.push({ model: Marca, where: { slug: brand_slug } });
    if (search) {
      where[Op.or] = [
        { nameEs: { [Op.iLike]: `%${search}%` } },
        { descriptionEs: { [Op.iLike]: `%${search}%` } },
        { usesEs: { [Op.iLike]: `%${search}%` } },
        { propertiesEs: { [Op.iLike]: `%${search}%` } },
      ];
    }
    const items = await Producto.findAll({ where, include, order: [["order", "ASC"], ["created_at", "DESC"]] });
    res.json(items);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error?.original?.detail || 'Error al listar productos' });
  }
};

const getBySlug = async (req, res) => {
  try {
    const { slug } = req.params;
    const item = await Producto.findOne({ where: { slug }, include: [Categoria, Subcategoria, Marca] });
    if (!item) return res.status(404).json({ error: 'Producto no encontrado' });
    res.json(item);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error?.original?.detail || 'Error al buscar producto por slug' });
  }
};

module.exports = { list, getBySlug };
