const { Product, Category, Subcategory, Brand, InternalProduct, Presentation, Variety, ProductDiscount } = require('../models');
const { Op } = require('sequelize');

function applyLang(record, lang) {
  // Map Rails-like multilingual fields to a normalized shape
  const name = record[`name_${lang}`] || record.name_es;
  const description = record[`description_${lang}`] || record.description_es;
  const uses = record[`uses_${lang}`] || record.uses_es;
  return { name, description, uses };
}

async function list(req, res) {
  const { category_slug, subcategory_slug, brand_slug, search, lang = 'es' } = req.query;

  const where = {};
  const include = [];

  if (category_slug) include.push({ model: Category, where: { slug: category_slug } });
  if (subcategory_slug) include.push({ model: Subcategory, where: { slug: subcategory_slug } });
  if (brand_slug) include.push({ model: Brand, where: { slug: brand_slug } });

  if (search) {
    where[Op.or] = [
      { name_es: { [Op.iLike]: `%${search}%` } },
      { name_en: { [Op.iLike]: `%${search}%` } },
      { name_br: { [Op.iLike]: `%${search}%` } },
      { description_es: { [Op.iLike]: `%${search}%` } },
      { description_en: { [Op.iLike]: `%${search}%` } },
      { description_br: { [Op.iLike]: `%${search}%` } },
      { uses_es: { [Op.iLike]: `%${search}%` } },
      { uses_en: { [Op.iLike]: `%${search}%` } },
      { uses_br: { [Op.iLike]: `%${search}%` } },
      { properties_es: { [Op.iLike]: `%${search}%` } },
      { properties_en: { [Op.iLike]: `%${search}%` } },
      { properties_br: { [Op.iLike]: `%${search}%` } },
    ];
  }

  const items = await Product.findAll({ where, include, order: [["order", "ASC"], ["created_at", "DESC"]] });
  const shaped = items.map(p => ({
    id: p.id,
    slug: p.slug,
    category_id: p.category_id,
    subcategory_id: p.subcategory_id,
    brand_id: p.brand_id,
    featured: p.featured,
    active: p.active,
    order: p.order,
    ...applyLang(p, String(lang))
  }));
  res.json(shaped);
}

async function getBySlug(req, res) {
  const { slug } = req.params;
  const { lang = 'es' } = req.query;
  const product = await Product.findOne({ where: { slug }, include: [Category, Subcategory, Brand, { model: InternalProduct, include: [Presentation, Variety] }] });
  if (!product) return res.status(404).json({ message: 'Product not found' });

  const { name, description, uses } = applyLang(product, String(lang));

  const variants = (product.InternalProducts || product.internal_products || []).map(ip => ({
    id: ip.id,
    internal_code: ip.internal_code,
    price: Number(ip.price || 0),
    active: ip.active,
    featured: ip.featured,
    main: ip.main,
    presentation: { id: ip.presentation_id, name: ip.Presentation?.name_es },
    variety: { id: ip.variety_id, name: ip.Variety?.name_es },
  }));

  res.json({
    id: product.id,
    slug: product.slug,
    category_id: product.category_id,
    subcategory_id: product.subcategory_id,
    brand_id: product.brand_id,
    featured: product.featured,
    active: product.active,
    order: product.order,
    name,
    description,
    uses,
    variants,
  });
}

module.exports = { list, getBySlug };
