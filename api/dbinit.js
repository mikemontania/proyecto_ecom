const { 
  Category,
  Subcategory,
  Brand,
  Presentation,
  Variety,
  InternalProduct,
  MeasurementUnit,
  DeliveryMethod,
  PaymentMethod,
  Discount,
  Page,
  Customer,
} = require('./src/models');
const bcrypt = require('bcryptjs');

const populateDB = async () => {
  console.log('populateDB');
  if (process.env.DB_INIT == 'true') {
    // Admin creation is omitted on purpose (security). Use Customer demo instead.

    // Presentations
    const presentations = [
      { name_es: 'Bidón de 4L', active: true },
      { name_es: 'Bolsa de 80g', active: true },
      { name_es: 'Bolsa de 200g', active: true },
      { name_es: 'Bolsa de 400g', active: true },
      { name_es: 'Bolsa de 600g', active: true },
      { name_es: 'Bolsa de 800g', active: true },
      { name_es: 'Bolsa de 2Kg', active: true },
      { name_es: 'Bolsa de 3,4Kg', active: true },
      { name_es: 'Bolsa de 5Kg', active: true },
      { name_es: 'Bolsa de 10Kg', active: true },
      { name_es: 'Bolsa de 150g', active: true },
      { name_es: 'Bolsa de 1Kg', active: true },
      { name_es: 'Bolsa de 3Kg', active: true },
      { name_es: 'Pan de 60g', active: true },
      { name_es: 'Pan de 100g', active: true },
      { name_es: 'Pan de 200g', active: true },
      { name_es: 'Pack 10 x 40g', active: true },
      { name_es: 'Barra de 500g', active: true },
      { name_es: 'Barra de 1000g', active: true },
      { name_es: 'Pan de 180g', active: true },
      { name_es: 'Pan de 130g', active: true },
      { name_es: 'Pack de 5 x 180g', active: true },
      { name_es: 'Pan de 250g', active: true },
      { name_es: 'Pan de 230g', active: true },
    ];
    await Presentation.bulkCreate(presentations, { ignoreDuplicates: true });

    // Categories + Subcategories
    const categories = [
      { name_es: 'Cuidado de las Prendas', slug: 'cuidado-de-las-prendas', active: true, display_order: 1, sub: [
        'Bolsas', 'Desodorante', 'Detergente', 'Lavandina', 'Trapos'] },
      { name_es: 'Higiene Personal', slug: 'higiene-personal', active: true, display_order: 2, sub: [
        'Coco Puro', 'Jabón de lavar', 'Jabón en polvo', 'Jabón prensado', 'Suavizante'] },
      { name_es: 'Limpieza y Desinfeccion del Hogar', slug: 'limpieza-y-desinfeccion-del-hogar', active: true, display_order: 3, sub: [
        'Coco Puro', 'Tocador'] },
    ];
    for (const c of categories) {
      const cat = await Category.findOrCreate({ where: { slug: c.slug }, defaults: { name_es: c.name_es, slug: c.slug, active: c.active, display_order: c.display_order } }).then(r => r[0]);
      for (const s of c.sub) {
        const subSlug = s.toLowerCase().replace(/\s+/g, '-');
        await Subcategory.findOrCreate({ where: { slug: subSlug, category_id: cat.id }, defaults: { name_es: s, slug: subSlug, active: true, category_id: cat.id } });
      }
    }

    // Brands
    const brands = [
      'Cavallaro','Pixol','Agricultor','Obrero','C','C2','Guairá Extra','Guairá Deluxe','Coco Puro','Insuperable','Guairá Opti-System','gliCrina','Sole Mio','Cavallaro Premium'
    ];
    for (let i = 0; i < brands.length; i++) {
      const name = brands[i];
      const slug = name.toLowerCase().replace(/\s+/g, '-');
      await Brand.findOrCreate({ where: { slug }, defaults: { name, slug, order: i + 1, active: true } });
    }

    // Varieties (sample subset; expand as needed from seeds.rb)
    const varieties = [
      { name_es: 'Azahar', color: '#258f00', active: true },
      { name_es: 'Lavanda', color: '#ffd600', active: true },
      { name_es: 'Uva', color: '#7d00c9', active: true },
      { name_es: 'Clásico', color: '#00a3ff', active: true },
    ];
    await Variety.bulkCreate(varieties, { ignoreDuplicates: true });

    // Measurement Units
    const mus = [
      { code: 'CJ', name: 'Caja' },{ code: 'DSP', name: 'Display' },{ code: 'PCK', name: 'Pack' },{ code: 'ROL', name: 'Rollo' },{ code: 'UN', name: 'Unidad' }
    ];
    for (const mu of mus) {
      await MeasurementUnit.findOrCreate({ where: { code: mu.code }, defaults: mu });
    }

    // Delivery/Payment Methods
    await DeliveryMethod.bulkCreate([
      { name: 'Delivery', active: true, carry_out: false },
      { name: 'Pasar a buscar', active: true, carry_out: true },
    ], { ignoreDuplicates: true });

    await PaymentMethod.bulkCreate([
      { name: 'Pago Online - Ocasional', active: true, internal_name: 'bancard' },
      { name: 'Contra Entrega', active: true, internal_name: 'contra_entrega' },
      { name: 'Pago Zimple', active: true, internal_name: 'zimple' },
      { name: 'Pago Online - Mis tarjetas', active: true, internal_name: 'bancard_token' },
    ], { ignoreDuplicates: true });

    // Pages
    await Page.bulkCreate([
      { title_es: 'Empresa', slug: 'empresa', content_es: '<p>Sobre la empresa Cavallaro.</p>', order: 1, active: true },
      { title_es: 'Contacto', slug: 'contacto', content_es: '<p>Formulario de contacto.</p>', order: 2, active: true },
    ], { ignoreDuplicates: true });

    // Customer demo
    const hash = await bcrypt.hash('demo1234', 10);
    await Customer.findOrCreate({ where: { email: 'demo@cavallaro.com.py' }, defaults: { firstName: 'Demo', lastName: 'User', email: 'demo@cavallaro.com.py', phone: '0981000000', password_hash: hash } });

    // Discounts (use unified Discount)
    await Discount.bulkCreate([
      { type: 'AMOUNT', qty_from: 20000, qty_to: 65000, value: 5, start_date: '2019-01-01', end_date: '2050-12-31' },
      { type: 'AMOUNT', qty_from: 65001, qty_to: 200000, value: 10, start_date: '2019-01-01', end_date: '2050-12-31' },
      { type: 'AMOUNT', qty_from: 200001, qty_to: 500000, value: 15, start_date: '2019-01-01', end_date: '2050-12-31' },
      { type: 'AMOUNT', qty_from: 500001, qty_to: 999999999, value: 25, start_date: '2019-01-01', end_date: '2050-12-31' },
    ], { ignoreDuplicates: true });
  }
};

module.exports = { populateDB };
