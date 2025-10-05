const { Category, Product, Discount, Page, Customer } = require('./src/models');
const bcrypt = require('bcryptjs');
const { sequelize } = require('./dbconfig');
const fs = require('fs');
const path = require('path');

async function importCatalogIfPresent() {
  const file = path.join(__dirname, 'data', 'catalog.json');
  if (!fs.existsSync(file)) return false;

  const raw = fs.readFileSync(file, 'utf8');
  const data = JSON.parse(raw);

  // Import categories
  if (Array.isArray(data.categories)) {
    for (const c of data.categories) {
      await Category.findOrCreate({
        where: { slug: c.slug },
        defaults: {
          name_es: c.name_es,
          slug: c.slug,
          description: c.description || null,
          image_url: c.image_url || null,
          display_order: c.display_order || 0,
          active: c.active ?? true,
        },
      });
    }
  }

  // Map categories by slug and ensure a default subcategory per category
  const cats = await Category.findAll();
  const slugToCategoryId = new Map(cats.map(c => [c.slug, c.id]));
  const { Subcategory } = require('./src/models');
  const catToSubcatId = new Map();
  for (const c of cats) {
    const [sub] = await Subcategory.findOrCreate({
      where: { slug: 'general', category_id: c.id },
      defaults: { name_es: 'General', slug: 'general', active: true, category_id: c.id },
    });
    catToSubcatId.set(c.slug, sub.id);
  }

  // Import products; use provided id as primary id and assign default subcategory when missing
  if (Array.isArray(data.products)) {
    for (const p of data.products) {
      const category_id = slugToCategoryId.get(p.category_slug);
      if (!category_id) continue;
      const subcategory_id = p.subcategory_slug
        ? (await Subcategory.findOne({ where: { slug: p.subcategory_slug, category_id } }))?.id || catToSubcatId.get(p.category_slug)
        : catToSubcatId.get(p.category_slug);
      // Upsert by id (SKU)
      const [record] = await Product.findOrCreate({
        where: { id: p.id },
        defaults: {
          id: p.id,
          name_es: p.name_es || p.name,
          slug: p.slug,
          description_es: p.description_es || p.description || null,
          uses_es: p.uses_es || p.recommended_uses || null,
          properties_es: p.properties_es || p.properties || null,
          category_id,
          subcategory_id,
          featured: !!p.featured || !!p.is_featured,
        },
      });
      // Optionally update if exists
      if (record && p._update === true) {
        await record.update({
          name_es: p.name_es || p.name,
          slug: p.slug,
          description_es: p.description_es || p.description || null,
          uses_es: p.uses_es || p.recommended_uses || null,
          properties_es: p.properties_es || p.properties || null,
          category_id,
          subcategory_id,
          featured: !!p.featured || !!p.is_featured,
        });
      }
    }
    // Fix sequences for explicit IDs
    await sequelize.query("SELECT setval(pg_get_serial_sequence('products','id'), (SELECT MAX(id) FROM products));");
  }

  return true;
}

async function importDiscountsIfPresent() {
  const file = path.join(__dirname, 'data', 'discounts.json');
  if (!fs.existsSync(file)) return false;
  const raw = fs.readFileSync(file, 'utf8');
  let data;
  try {
    data = JSON.parse(raw);
  } catch (_) {
    console.error('discounts.json inválido');
    return false;
  }
  if (!Array.isArray(data) || data.length === 0) return false;
  const count = await Discount.count();
  if (count > 0) return true; // ya hay descuentos
  await Discount.bulkCreate(data.map(d => ({
    type: d.type,
    sku_from: d.sku_from ?? null,
    sku_to: d.sku_to ?? null,
    qty_from: d.qty_from ?? null,
    qty_to: d.qty_to ?? null,
    value: d.value,
    start_date: d.start_date,
    end_date: d.end_date,
    product_id: d.product_id ?? null,
  })));
  return true;
}

async function populateDB() {
  try {
    // Evitar duplicados en cargas repetidas
    const categoriesCount = await Category.count();
    // Intentar importar catálogo completo desde data/catalog.json si existe
    const imported = await importCatalogIfPresent();
    if (!imported && categoriesCount === 0) {
      // Minimal seed aligned to Rails seeds.rb structure
      const catCare = await Category.create({ name: 'Cuidado de las Prendas', slug: 'cuidado-de-las-prendas', description: '', display_order: 1 });
      await Category.create({ name: 'Higiene Personal', slug: 'higiene-personal', description: '', display_order: 2 });
      await Category.create({ name: 'Limpieza y Desinfeccion del Hogar', slug: 'limpieza-y-desinfeccion-del-hogar', description: '', display_order: 3 });

      await Product.bulkCreate([
        { id: 300000624, name: 'JABON LIQUIDO PARA LAVAR LA ROPA COCO CAVALLARO 1', slug: 'jabon-liquido-coco-cavallaro-1', price: 46000, image_url: 'https://cdn.cavallaro.com.py/productos/300000624.jpg', stock: 100, category_id: catCare.id, is_featured: true },
        { id: 300000623, name: 'JABON LIQUIDO PARA LAVAR LA ROPA COCO CAVALLARO 2', slug: 'jabon-liquido-coco-cavallaro-2', price: 46000, image_url: 'https://cdn.cavallaro.com.py/productos/300000623.jpg', stock: 100, category_id: catCare.id, is_new: true },
        { id: 300000231, name: 'JABON PARA LAVAR LA ROPA AGRICULTOR', slug: 'jabon-lavar-ropa-agricultor', price: 71280, image_url: 'https://cdn.cavallaro.com.py/productos/300000231.jpg', stock: 100, category_id: catCare.id },
      ]);
      await sequelize.query("SELECT setval(pg_get_serial_sequence('products','id'), (SELECT MAX(id) FROM products));");

      // Minimal CMS pages to test Angular
      await Page.bulkCreate([
        { title_es: 'Empresa', slug: 'empresa', content_es: '<p>Sobre la empresa Cavallaro.</p>', order: 1, active: true },
        { title_es: 'Contacto', slug: 'contacto', content_es: '<p>Formulario de contacto.</p>', order: 2, active: true },
      ]);

      // Demo customer for login
      const hash = await bcrypt.hash('demo1234', 10);
      await Customer.findOrCreate({ where: { email: 'demo@cavallaro.com.py' }, defaults: { firstName: 'Demo', lastName: 'User', email: 'demo@cavallaro.com.py', phone: '0981000000', password_hash: hash } });
    }

    // Descuentos: intentar importar desde data/discounts.json; si no, seed por defecto
    const importedDiscounts = await importDiscountsIfPresent();
    if (!importedDiscounts) {
      const discountCount = await Discount.count();
      if (discountCount === 0) {
        await Discount.bulkCreate([
          // AMOUNT por rango de montos (usa qty_from/qty_to como rango de monto en Gs)
          { type: 'AMOUNT', qty_from: 1000001, qty_to: 999999999, value: 25, start_date: '2025-04-01', end_date: '9999-01-01' },
          { type: 'AMOUNT', qty_from: 500001, qty_to: 999999, value: 20, start_date: '2025-04-01', end_date: '9999-01-01' },
          { type: 'AMOUNT', qty_from: 200001, qty_to: 500000, value: 15, start_date: '2025-04-01', end_date: '9999-01-01' },
          { type: 'AMOUNT', qty_from: 65001, qty_to: 200000, value: 10, start_date: '2025-04-01', end_date: '9999-01-01' },
          { type: 'AMOUNT', qty_from: 20000, qty_to: 65000, value: 5, start_date: '2025-04-01', end_date: '9999-01-01' },
          // PRODUCT: descuento por SKU/producto específico (ejemplo 300000231 con 20%)
          { type: 'PRODUCT', product_id: 300000231, value: 20, start_date: '2025-04-02', end_date: '9999-01-02' },
        ]);
      }
    }
  } catch (err) {
    console.error('Error populating DB', err);
  }
}

module.exports = { populateDB };
