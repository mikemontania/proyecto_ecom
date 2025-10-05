if Admin.where(email: 'desarrollo@creadores.com.py').count.zero?
  Admin.create(email: 'desarrollo@creadores.com.py', password: 'dameunpassword')
end

# Presentation seeders
if Presentation.all.count.zero?

  presentations = [
    { name_es: 'Bidón de 4L', name_en: '', name_br: 'Garrafa de 4L', active: true },
    { name_es: 'Bolsa de 80g', name_en: '', name_br: 'Embalagem de 80g', active: true },
    { name_es: 'Bolsa de 200g', name_en: '', name_br: 'Embalagem de 80g', active: true },
    { name_es: 'Bolsa de 400g', name_en: '', name_br: 'Embalagem de 400g', active: true },
    { name_es: 'Bolsa de 600g',    name_en: '',    name_br: 'Embalagem de 600g',    active: true },
    { name_es: 'Bolsa de 800g',    name_en: '',    name_br: 'Embalagem de 800g',    active: true },
    { name_es: 'Bolsa de 2Kg', name_en: '', name_br: 'Embalagem de 2Kg', active: true },
    { name_es: 'Bolsa de 3,4Kg', name_en: '', name_br: 'Embalagem de 3,4 Kg', active: true },
    { name_es: 'Bolsa de 5Kg', name_en: '', name_br: 'Embalagem de 5Kg', active: true },
    { name_es: 'Bolsa de 10Kg',    name_en: '',    name_br: 'Embalagem de 10Kg',    active: true },
    { name_es: 'Bolsa de 150g',    name_en: '',    name_br: 'Embalagem de 150g',    active: true },
    { name_es: 'Bolsa de 1Kg',    name_en: '',    name_br: 'Embalagem de 1Kg',    active: true },
    { name_es: 'Bolsa de 3Kg',    name_en: '',    name_br: 'Embalagem de 3Kg',    active: true },
    { name_es: 'Pan de 60g', name_en: '', name_br: '', active: true },
    { name_es: 'Pan de 100g', name_en: '', name_br: '', active: true },
    { name_es: 'Pan de 200g', name_en: '', name_br: '', active: true },
    { name_es: 'Pack 10 x 40g', name_en: '', name_br: '', active: true },
    { name_es: 'Barra de 500g', name_en: '', name_br: '', active: true },
    { name_es: 'Barra de 1000g', name_en: '', name_br: '', active: true },
    { name_es: 'Pan de 180g', name_en: '', name_br: '', active: true },
    { name_es: 'Pan de 130g', name_en: '', name_br: '', active: true },
    { name_es: 'Pack de 5 x 180g', name_en: '', name_br: '',    active: true },
    { name_es: 'Pan de 250g',    name_en: '',    name_br: '',    active: true },
    { name_es: 'Pan de 230g',    name_en: '',    name_br: '',    active: true }
  ]

  presentations.each { |p| Presentation.create(p) }
end

# Only one delivery schedule
if DeliverySchedule.where(id: 1).count.zero?
  DeliverySchedule.create(
    title: '',
    week_start_hour: '00:00',
    week_end_hour: '00:00',
    weekend_start_hour: '00:00',
    weekend_end_hour: '00:00',
    holydays: ''
  )
end

# Category and subcategory seeders

if Category.all.count.zero?
  Category.create(
    name_es: 'Cuidado de las Prendas',
    name_en: '',
    name_br: '',
    active: true
  ).subcategories.create(
    [
      { name_es: 'Bolsas', name_en: '', name_br: '', active: true },
      { name_es: 'Desodorante', name_en: '', name_br: '', active: true },
      { name_es: 'Detergente',        name_en: '', name_br: '', active: true },
      { name_es: 'Lavandina', name_en: '', name_br: '', active: true },
      { name_es: 'Trapos', name_en: '', name_br: '', active: true }
    ]
  )
  Category.create(
    name_es: 'Higiene Personal',
    name_en: '',
    name_br: '',
    active: true
  ).subcategories.create(
    [
      { name_es: 'Coco Puro', name_en: '', name_br: '', active: true },
      { name_es: 'Jabón de lavar', name_en: '', name_br: '', active: true },
      { name_es: 'Jabón en polvo', name_en: '', name_br: '', active: true },
      { name_es: 'Jabón prensado', name_en: '', name_br: '', active: true },
      { name_es: 'Suavizante', name_en: '', name_br: '', active: true }
    ]
  )
  Category.create(
    name_es: 'Limpieza y Desinfeccion del Hogar',
    name_en: '',
    name_br: '',
    active: true
  ).subcategories.create(
    [
      { name_es: 'Coco Puro', name_en: '', name_br: '', active: true },
      { name_es: 'Tocador', name_en: '', name_br: '', active: true }
    ]
  )
end

# Brand seeders
if Brand.all.count.zero?
  Brand.create(
    [
      { name: 'Cavallaro', active: true, order: 1 },
      { name: 'Pixol', active: true, order: 2 },
      { name: 'Agricultor', active: true, order: 3 },
      { name: 'Obrero', active: true, order: 4 },
      { name: 'C', active: true, order: 5 },
      { name: 'C2', active: true, order: 6 },
      { name: 'Guairá Extra', active: true, order: 7 },
      { name: 'Guairá Deluxe', active: true, order: 8 },
      { name: 'Coco Puro', active: true, order: 9 },
      { name: 'Insuperable', active: true, order: 10 },
      { name: 'Guairá Opti-System', active: true, order: 11 },
      { name: 'gliCrina', active: true, order: 12 },
      { name: 'Sole Mio', active: true, order: 13 },
      { name: 'Cavallaro Premium', active: true, order: 14 }
    ]
  )
end

# Varieties seeders
if Variety.all.count.zero?
  varieties = [
    { name_es: 'Azahar', name_en: 'Azahar', name_br: 'Azahar', active: true, color: '#258f00' },
    { name_es: 'Lavanda', name_en: 'Lavanda', name_br: 'Lavanda', active: true, color: '#ffd600' },
    { name_es: 'Uva', name_en: 'Uva', name_br: 'Uva', active: true, color: '#7d00c9' },
    { name_es: 'Fantasía', name_en: 'Fantasía', name_br: 'Fantasia', active: true, color: '#ff0099' },
    { name_es: 'Clásico', name_en: 'Clásico', name_br: 'Clásico', active: true, color: '#00a3ff' },
    { name_es: 'Delicado', name_en: 'Delicado', name_br: 'Delicado', active: true, color: '#ffd600' },
    { name_es: 'Intenso', name_en: 'Intenso', name_br: 'Intenso', active: true, color: '#92d99a' },
    { name_es: 'Essences', name_en: 'Essences', name_br: 'Essences', active: true, color: '#eda28b' },
    { name_es: 'Neutro', name_en: 'Neutro', name_br: 'Neutro', active: true, color: '#bdbdbd' },
    { name_es: 'Blue', name_en: 'Blue', name_br: 'Blue', active: true, color: '#02b3e5' },
    { name_es: 'White', name_en: 'White', name_br: 'White', active: true, color: '#bae0e1' },
    { name_es: 'Green', name_en: 'Green', name_br: 'Green', active: true, color: '#c4e361' },
    { name_es: 'Pink', name_en: 'Pink', name_br: 'Pink', active: true, color: '#e85896' },
    { name_es: 'Orange', name_en: 'Orange', name_br: 'Orange', active: true, color: '#fa9523' },
    { name_es: 'Yellow', name_en: 'Yellow', name_br: 'Yellow', active: true, color: '#fed627' },
    { name_es: 'Sensaciones', name_en: 'Sensaciones', name_br: 'Sensações', active: true, color: '#5e4e97' },
    { name_es: 'Urbano Sensual', name_en: 'Urbano Sensual', name_br: 'Urbano Sensual', active: true, color: '#999896' },
    { name_es: 'Armonía y Relajación', name_en: 'Armonía y Relajación', name_br: 'Harmonia e Relaxamento', active: true, color: '#295e6e' },
    { name_es: 'Misterio del Oriente', name_en: 'Misterio del Oriente', name_br: 'Mistério do Oriente', active: true, color: '#cb803d' },
    { name_es: 'Fruit & Flower', name_en: 'Fruit & Flower', name_br: 'Fruit & Flower', active: true, color: '#cf633c' },
    { name_es: 'Glamour', name_en: 'Glamour', name_br: 'Glamour', active: true, color: '#dfaca9' },
    { name_es: 'Acción', name_en: 'Acción', name_br: 'Ação', active: true, color: '#86b490' },
    { name_es: 'Romance', name_en: 'Romance', name_br: 'Romance', active: true, color: '#d9d2c2' },
    { name_es: 'Intimo', name_en: 'Intimo', name_br: 'Intimo', active: true, color: '#eece79' },
    { name_es: 'Frescura Marina', name_en: 'Frescura Marina', name_br: 'Frescura Marina', active: true, color: '#63a6af' },
    { name_es: 'Rubí', name_en: 'Rubí', name_br: 'Rubi', active: true, color: '#be4a53' },
    { name_es: 'Esmeralda', name_en: 'Esmeralda', name_br: 'Esmeralda', active: true, color: '#347a56' },
    { name_es: 'Ambar', name_en: 'Ambar', name_br: 'Âmbar', active: true, color: '#e0b431' },
    { name_es: 'Azul Blanqueador', name_en: 'Azul Blanqueador', name_br: 'Azul Alvejante', active: true, color: '#4284b4' },
    { name_es: 'Glicerina y Limón', name_en: 'Glicerina y Limón', name_br: 'Glicerina e Limāo', active: true, color: '#5e745d' },
    { name_es: 'Coco y Glicerina', name_en: 'Coco y Glicerina', name_br: 'Coco e Glicerina', active: true, color: '#d5ccbd' },
    { name_es: 'Verde', name_en: 'verde', name_br: 'Verde', active: true, color: '#576452' },
    { name_es: 'Marrón', name_en: 'Marrón', name_br: 'Marrom', active: true, color: '#a58860' },
    { name_es: 'Blanco', name_en: 'Blanco', name_br: 'Branco', active: true, color: '#ebe1d5' },
    { name_es: 'Rosado', name_en: 'Rosado', name_br: 'Rosa', active: true, color: '#dfbfd4' },
    { name_es: 'Normal', name_en: 'Normal', name_br: 'Normal', active: true, color: '#de4c43' },
    { name_es: 'Limón', name_en: 'Limón', name_br: 'Limão', active: true, color: '#6fa521' },
    { name_es: 'Manzana', name_en: 'Manzana', name_br: 'Maçã', active: true, color: '#f75002' },
    { name_es: 'Ropa delicada y Elastizada', name_en: 'Ropa delicada y Elastizada', name_br: 'Ropa delicada y Elastizada', active: true, color: '#b99869' },
    { name_es: 'Ropa de bebé', name_en: 'Ropa de bebé', name_br: 'Ropa de bebé', active: true, color: '#e97e8f' },
    { name_es: 'Clásico', name_en: 'Clásico', name_br: 'Clásico.', active: true, color: '#d9c5a0' },
    { name_es: 'Floral', name_en: 'Floral', name_br: 'Floral', active: true, color: '#e3c4c7' },
    { name_es: 'Almendras', name_en: 'Almendras', name_br: 'Almendras', active: true, color: '#c2c39d' },
    { name_es: 'Guaira Opti-Fiber', name_en: 'Guaira Opti-Fiber', name_br: 'Guaira Opti-Fiber', active: true, color: '#014498' },
    { name_es: 'Guaira Opti-Colors', name_en: 'Guaira Opti-Colors', name_br: 'Guaira Opti-Colors', active: true, color: '#f9341c' },
    { name_es: 'Dulce Sensación', name_en: 'Dulce Sensación', name_br: 'Dulce Sensación', active: true, color: '#ff1572' },
    { name_es: 'Frescura Intensa', name_en: 'Frescura Intensa', name_br: 'Frescura Intensa', active: true, color: '#009719' },
    { name_es: 'Sueve Susuro', name_en: 'Sueve Susuro', name_br: 'Sueve Susuro', active: true, color: '#778fd9' },
    { name_es: 'Energía Vital', name_en: 'Energía Vital', name_br: 'Energía Vital', active: true, color: '#ffa500' },
    { name_es: 'Brisa Fresca', name_en: 'Brisa Fresca', name_br: 'Brisa Fresca', active: true, color: '#00abeb' },
    { name_es: 'Sensación Tropical', name_en: 'Sensación Tropical', name_br: 'Sensación Tropical', active: true, color: '#ff4701' }
  ]

  varieties.each { |v| Variety.create(v) }
end

# Product seeders
if Product.all.count.zero?
  pres_id = Presentation.all.first.id
  var_id = Variety.all.first.id

  Product.create(
    name_es: 'BOLSA PARA RESIDUOS PIXOL - BAÑO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '500000004', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '500000005', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'BOLSA PARA RESIDUOS PIXOL - SUPER RESISTENTE', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '500000001', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '500000002', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '500000003', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'DESODORANTE DE AMBIENTE CAVALLARO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000024', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000012', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000027', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000021', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000026', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000022', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000025', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000011', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'DETERGENTE LAVAVAJILLA CAVALLARO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000016', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000015', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'DETERGENTE LAVAVAJILLA PIXOL', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000103', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000100', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000104', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000102', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000105', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000101', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON DE COCO PURO COCO CAVALLARO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000002', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000003', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000052', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000000', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000629', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000050', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON DE TOCADOR C GLICERINA', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000605', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000604', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000603', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON DE TOCADOR C2', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000135', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000113', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000125', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000333', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000116', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000134', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000332', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000114', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000127', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000334', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000128', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000115', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000126', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000335', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON DE TOCADOR COCO CAVALLARO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000053', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000056', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000064', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000057', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000065', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000055', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000453', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000625', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON DE TOCADOR IO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000136', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000137', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000138', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON DE TOCADOR PARA HOTEL C', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000153', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON DE TOCADOR PARA HOTEL MIO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000009', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000109', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON EN POLVO COCO CAVALLARO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000079', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000080', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000078', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000081', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000075', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000086', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000074', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000087', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])

  Product.create(
    name_es: 'JABON LIQUIDO "MULTIUSO" COCO CAVALLARO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000628', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON LIQUIDO PARA LAVAR LA ROPA COCO CAVALLARO', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000623', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000624', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON PARA LAVAR LA ROPA AGRICULTOR', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000224', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000222', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000225', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000223', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON PARA LAVAR LA ROPA GUAIRA DELUXE', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000097', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000092', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000096', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000095', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000098', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON PARA LAVAR LA ROPA GUAIRA EXTRA', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000090', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000088', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000093', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000091', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000089', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000094', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'JABON PARA LAVAR LA ROPA TROPICAL', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000362', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000365', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000363', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000364', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])

  Product.create(
    name_es: 'LAVANDINA CAVALLARO CONCENTRADA', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000008', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000007', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])

  Product.create(
    name_es: 'POLVO PARA LAVAR LA ROPA GUAIRA', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000255', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000256', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000254', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000257', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000444', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000251', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000252', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000250', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000253', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])

  Product.create(
    name_es: 'POLVO PARA LAVAR LA ROPA GUAIRA DELUXE', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000248', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000249', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000246', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000247', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'POLVO PARA LAVAR LA ROPA GUAIRA EXTRA', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000243', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000241', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000239', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000240', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'POLVO PARA LAVAR LA ROPA GUAIRA PROFESIONAL', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000276', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000277', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000610', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'POLVO PARA LAVAR LA ROPA INSUPERABLE', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000237', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000232', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000230', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000231', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000233', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000235', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000234', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000236', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000229', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000238', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'SUAVIZANTE CAVALLARO EDICION ESPECIAL', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000494', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000492', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000495', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000273', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000270', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000497', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000275', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000272', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000493', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000496', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000274', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000271', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'SUAVIZANTE CAVALLARO PREMIUM', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000044', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000023', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000038', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000029', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000048', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000030', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000046', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000033', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000045', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000036', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000616', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000042', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000040', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000031', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000448', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000035', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000037', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000039', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000043', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000041', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000032', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000047', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '300000034', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'TRAPO  DE PISO PIXOL', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '500000007', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false },
                               { internal_code: '500000006', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])
  Product.create(
    name_es: 'TOCADOR DE TOCADOR PARA HOTEL', active: true, featured: false, category_id: Category.all.first.id,
    subcategory_id: Subcategory.all.first.id, brand_id: Brand.all.first.id
  ).internal_products.create([
                               { internal_code: '300000110', price: 0, active: true, featured: false, presentation_id: pres_id, variety_id: var_id, main: false }
                             ])

end

# Slugs generations
Category.find_each(&:save)
Brand.find_each(&:save)
Brand.find_each(&:save)
Page.find_each(&:save)
Product.find_each(&:save)
InternalProduct.find_each(&:save)

# Measurement Units seeders
if MeasurementUnit.all.count.zero?
  MeasurementUnit.create([
                           { code: 'CJ', name: 'Caja' },
                           { code: 'DSP', name: 'Display' },
                           { code: 'PCK', name: 'Pack' },
                           { code: 'ROL', name: 'Rollo' },
                           { code: 'UN', name: 'Unidad' }
                         ])
end

# Asignment MeasurementUnit to InternalProducts
# products_to_modify = [

#   { code: '300000055', um:	'CJ' },
#   { code: '300000056', um:	'CJ' },
#   { code: '300000057', um:	'CJ' },
#   { code: '300000088', um:	'CJ' },
#   { code: '300000089', um:	'CJ' },
#   { code: '300000093', um:	'CJ' },
#   { code: '300000094', um:	'CJ' },
#   { code: '300000109', um:	'CJ' },
#   { code: '300000110', um:	'CJ' },
#   { code: '300000153', um:	'CJ' },
#   { code: '300000163', um:	'CJ' },
#   { code: '300000222', um:	'CJ' },
#   { code: '300000223', um:	'CJ' },
#   { code: '300000224', um:	'CJ' },
#   { code: '300000225', um:	'CJ' },
#   { code: '300000477', um:	'CJ' },
#   { code: '300000629', um:	'CJ' },
#   { code: '300000662', um:	'CJ' },
#   { code: '300000046', um:	'DSP' },
#   { code: '300000047', um:	'DSP' },
#   { code: '300000270', um:	'DSP' },
#   { code: '300000271', um:	'DSP' },
#   { code: '300000272', um:	'DSP' },
#   { code: '300000625', um:	'PCK' },
#   { code: '500000001', um:	'ROL' },
#   { code: '500000002', um:	'ROL' },
#   { code: '500000003', um:	'ROL' },
#   { code: '500000004', um:	'ROL' },
#   { code: '500000005', um:	'ROL' },
#   { code: '300000000', um:	'UN' },
#   { code: '300000002', um:	'UN' },
#   { code: '300000003', um:	'UN' },
#   { code: '300000003', um:	'UN' },
#   { code: '300000007', um:	'UN' },
#   { code: '300000008', um:	'UN' },
#   { code: '300000009', um:	'UN' },
#   { code: '300000011', um:	'UN' },
#   { code: '300000012', um:	'UN' },
#   { code: '300000015', um:	'UN' },
#   { code: '300000016', um:	'UN' },
#   { code: '300000021', um:	'UN' },
#   { code: '300000022', um:	'UN' },
#   { code: '300000023', um:	'UN' },
#   { code: '300000024', um:	'UN' },
#   { code: '300000025', um:	'UN' },
#   { code: '300000026', um:	'UN' },
#   { code: '300000027', um:	'UN' },
#   { code: '300000029', um:	'UN' },
#   { code: '300000030', um:	'UN' },
#   { code: '300000031', um:	'UN' },
#   { code: '300000032', um:	'UN' },
#   { code: '300000033', um:	'UN' },
#   { code: '300000034', um:	'UN' },
#   { code: '300000035', um:	'UN' },
#   { code: '300000036', um:	'UN' },
#   { code: '300000037', um:	'UN' },
#   { code: '300000038', um:	'UN' },
#   { code: '300000039', um:	'UN' },
#   { code: '300000040', um:	'UN' },
#   { code: '300000041', um:	'UN' },
#   { code: '300000042', um:	'UN' },
#   { code: '300000043', um:	'UN' },
#   { code: '300000044', um:	'UN' },
#   { code: '300000045', um:	'UN' },
#   { code: '300000048', um:	'UN' },
#   { code: '300000050', um:	'UN' },
#   { code: '300000052', um:	'UN' },
#   { code: '300000053', um:	'UN' },
#   { code: '300000064', um:	'UN' },
#   { code: '300000065', um:	'UN' },
#   { code: '300000074', um:	'UN' },
#   { code: '300000075', um:	'UN' },
#   { code: '300000078', um:	'UN' },
#   { code: '300000079', um:	'UN' },
#   { code: '300000080', um:	'UN' },
#   { code: '300000081', um:	'UN' },
#   { code: '300000086', um:	'UN' },
#   { code: '300000087', um:	'UN' },
#   { code: '300000090', um:	'UN' },
#   { code: '300000091', um:	'UN' },
#   { code: '300000092', um:	'UN' },
#   { code: '300000095', um:	'UN' },
#   { code: '300000096', um:	'UN' },
#   { code: '300000097', um:	'UN' },
#   { code: '300000098', um:	'UN' },
#   { code: '300000100', um:	'UN' },
#   { code: '300000101', um:	'UN' },
#   { code: '300000102', um:	'UN' },
#   { code: '300000103', um:	'UN' },
#   { code: '300000104', um:	'UN' },
#   { code: '300000105', um:	'UN' },
#   { code: '300000113', um:	'UN' },
#   { code: '300000114', um:	'UN' },
#   { code: '300000115', um:	'UN' },
#   { code: '300000116', um:	'UN' },
#   { code: '300000125', um:	'UN' },
#   { code: '300000126', um:	'UN' },
#   { code: '300000127', um:	'UN' },
#   { code: '300000128', um:	'UN' },
#   { code: '300000134', um:	'UN' },
#   { code: '300000135', um:	'UN' },
#   { code: '300000136', um:	'UN' },
#   { code: '300000137', um:	'UN' },
#   { code: '300000138', um:	'UN' },
#   { code: '300000229', um:	'UN' },
#   { code: '300000230', um:	'UN' },
#   { code: '300000231', um:	'UN' },
#   { code: '300000232', um:	'UN' },
#   { code: '300000233', um:	'UN' },
#   { code: '300000234', um:	'UN' },
#   { code: '300000235', um:	'UN' },
#   { code: '300000236', um:	'UN' },
#   { code: '300000237', um:	'UN' },
#   { code: '300000238', um:	'UN' },
#   { code: '300000239', um:	'UN' },
#   { code: '300000240', um:	'UN' },
#   { code: '300000241', um:	'UN' },
#   { code: '300000243', um:	'UN' },
#   { code: '300000246', um:	'UN' },
#   { code: '300000247', um:	'UN' },
#   { code: '300000248', um:	'UN' },
#   { code: '300000249', um:	'UN' },
#   { code: '300000250', um:	'UN' },
#   { code: '300000251', um:	'UN' },
#   { code: '300000252', um:	'UN' },
#   { code: '300000253', um:	'UN' },
#   { code: '300000254', um:	'UN' },
#   { code: '300000255', um:	'UN' },
#   { code: '300000256', um:	'UN' },
#   { code: '300000257', um:	'UN' },
#   { code: '300000273', um:	'UN' },
#   { code: '300000274', um:	'UN' },
#   { code: '300000275', um:	'UN' },
#   { code: '300000276', um:	'UN' },
#   { code: '300000277', um:	'UN' },
#   { code: '300000332', um:	'UN' },
#   { code: '300000333', um:	'UN' },
#   { code: '300000334', um:	'UN' },
#   { code: '300000335', um:	'UN' },
#   { code: '300000362', um:	'UN' },
#   { code: '300000363', um:	'UN' },
#   { code: '300000364', um:	'UN' },
#   { code: '300000365', um:	'UN' },
#   { code: '300000444', um:	'UN' },
#   { code: '300000448', um:	'UN' },
#   { code: '300000453', um:	'UN' },
#   { code: '300000492', um:	'UN' },
#   { code: '300000493', um:	'UN' },
#   { code: '300000494', um:	'UN' },
#   { code: '300000495', um:	'UN' },
#   { code: '300000496', um:	'UN' },
#   { code: '300000497', um:	'UN' },
#   { code: '300000603', um:	'UN' },
#   { code: '300000604', um:	'UN' },
#   { code: '300000605', um:	'UN' },
#   { code: '300000610', um:	'UN' },
#   { code: '300000616', um:	'UN' },
#   { code: '300000623', um:	'UN' },
#   { code: '300000624', um:	'UN' },
#   { code: '300000628', um:	'UN' },
#   { code: '500000006', um:	'UN' },
#   { code: '500000007', um:	'UN' }

# ]

# products_to_modify.each do |p|
#   ip = InternalProduct.find_by(internal_code: p[:code])
#   if ip.present?
#     ip.measurement_unit_code = p[:um]
#     ip.save!
#   end
# end

if DeliveryMethod.all.count.zero?
  DeliveryMethod.create(
    [
      { name: 'Delivery', active: true, internal_name: 'delivery' },
      { name: 'Pasar a buscar', active: true, internal_name: 'carry_out' }
    ]
  )
end

if PaymentMethod.all.count.zero?
  PaymentMethod.create(
    [
      { name: 'Pago Online - Ocasional', active: true, internal_name: 'bancard' },
      { name: 'Contra Entrega', active: true, internal_name: 'contra_entrega' },
      { name: 'Pago Zimple', active: true, internal_name: 'zimple' },
      { name: 'Pago Online - Mis tarjetas', active: true, internal_name: 'bancard_token' }
    ]
  )
end

pm_bancard = PaymentMethod.where(internal_name: 'bancard').first
if pm_bancard.present?
  pm_bancard.name = 'Pago Online - Ocasional'
  pm_bancard.save(validate: false)
end

pm_bancard_token = PaymentMethod.where(internal_name: 'bancard_token').first

if !pm_bancard_token.present?
  PaymentMethod.create(name: 'Pago Online - Mis Tarjetas', active: true, internal_name: 'bancard_token')
end

# Product prices - launch 01/12/2020
# products_prices = [
#   { internal_code: '300000000', price: 5800 },
#   { internal_code: '300000002', price: 13_000 },
#   { internal_code: '300000003', price: 2800 },
#   { internal_code: '300000003', price: 3500 },
#   { internal_code: '300000007', price: 51_000 },
#   { internal_code: '300000008', price: 96_000 },
#   { internal_code: '300000009', price: 10_800 },
#   { internal_code: '300000011', price: 44_000 },
#   { internal_code: '300000012', price: 44_000 },
#   { internal_code: '300000015', price: 6800 },
#   { internal_code: '300000016', price: 52_500 },
#   { internal_code: '300000021', price: 44_000 },
#   { internal_code: '300000022', price: 44_000 },
#   { internal_code: '300000023', price: 23_000 },
#   { internal_code: '300000024', price: 9100 },
#   { internal_code: '300000025', price: 9100 },
#   { internal_code: '300000026', price: 9100 },
#   { internal_code: '300000027', price: 9100 },
#   { internal_code: '300000029', price: 47_000 },
#   { internal_code: '300000030', price: 8000 },
#   { internal_code: '300000031', price: 8000 },
#   { internal_code: '300000032', price: 8000 },
#   { internal_code: '300000033', price: 13_800 },
#   { internal_code: '300000034', price: 13_800 },
#   { internal_code: '300000035', price: 106_700 },
#   { internal_code: '300000036', price: 23_000 },
#   { internal_code: '300000037', price: 23_000 },
#   { internal_code: '300000038', price: 25_000 },
#   { internal_code: '300000039', price: 25_000 },
#   { internal_code: '300000040', price: 7500 },
#   { internal_code: '300000041', price: 7500 },
#   { internal_code: '300000042', price: 47_000 },
#   { internal_code: '300000043', price: 47_000 },
#   { internal_code: '300000044', price: 106_700 },
#   { internal_code: '300000045', price: 106_700 },
#   { internal_code: '300000046', price: 32_000 },
#   { internal_code: '300000047', price: 32_000 },
#   { internal_code: '300000048', price: 7500 },
#   { internal_code: '300000050', price: 15_000 },
#   { internal_code: '300000052', price: 28_500 },
#   { internal_code: '300000053', price: 3500 },
#   { internal_code: '300000055', price: 200_000 },
#   { internal_code: '300000056', price: 200_000 },
#   { internal_code: '300000057', price: 200_000 },
#   { internal_code: '300000064', price: 3500 },
#   { internal_code: '300000065', price: 3500 },
#   { internal_code: '300000074', price: 1600 },
#   { internal_code: '300000075', price: 6000 },
#   { internal_code: '300000078', price: 1600 },
#   { internal_code: '300000079', price: 6000 },
#   { internal_code: '300000080', price: 11_200 },
#   { internal_code: '300000081', price: 22_000 },
#   { internal_code: '300000086', price: 11_200 },
#   { internal_code: '300000087', price: 22_000 },
#   { internal_code: '300000088', price: 40_000 },
#   { internal_code: '300000089', price: 40_000 },
#   { internal_code: '300000090', price: 1600 },
#   { internal_code: '300000091', price: 1600 },
#   { internal_code: '300000092', price: 2000 },
#   { internal_code: '300000093', price: 52_000 },
#   { internal_code: '300000094', price: 52_000 },
#   { internal_code: '300000095', price: 12_600 },
#   { internal_code: '300000096', price: 2850 },
#   { internal_code: '300000097', price: 3400 },
#   { internal_code: '300000098', price: 4250 },
#   { internal_code: '300000100', price: 3800 },
#   { internal_code: '300000101', price: 3800 },
#   { internal_code: '300000102', price: 3800 },
#   { internal_code: '300000103', price: 35_000 },
#   { internal_code: '300000104', price: 35_000 },
#   { internal_code: '300000105', price: 35_000 },
#   { internal_code: '300000109', price: 160_000 },
#   { internal_code: '300000110', price: 160_000 },
#   { internal_code: '300000113', price: 3700 },
#   { internal_code: '300000114', price: 3700 },
#   { internal_code: '300000115', price: 3700 },
#   { internal_code: '300000116', price: 3700 },
#   { internal_code: '300000125', price: 2700 },
#   { internal_code: '300000126', price: 2700 },
#   { internal_code: '300000127', price: 2700 },
#   { internal_code: '300000128', price: 2700 },
#   { internal_code: '300000134', price: 2700 },
#   { internal_code: '300000135', price: 2700 },
#   { internal_code: '300000136', price: 5100 },
#   { internal_code: '300000137', price: 5100 },
#   { internal_code: '300000138', price: 5100 },
#   { internal_code: '300000153', price: 231_000 },
#   { internal_code: '300000163', price: 240_000 },
#   { internal_code: '300000222', price: 52_000 },
#   { internal_code: '300000223', price: 52_000 },
#   { internal_code: '300000224', price: 40_000 },
#   { internal_code: '300000225', price: 40_000 },
#   { internal_code: '300000229', price: 71_280 },
#   { internal_code: '300000230', price: 9000 },
#   { internal_code: '300000231', price: 71_280 },
#   { internal_code: '300000232', price: 4000 },
#   { internal_code: '300000233', price: 1500 },
#   { internal_code: '300000234', price: 4000 },
#   { internal_code: '300000235', price: 26_000 },
#   { internal_code: '300000236', price: 9000 },
#   { internal_code: '300000237', price: 26_000 },
#   { internal_code: '300000238', price: 1500 },
#   { internal_code: '300000239', price: 6800 },
#   { internal_code: '300000240', price: 11_900 },
#   { internal_code: '300000241', price: 25_000 },
#   { internal_code: '300000243', price: 92_400 },
#   { internal_code: '300000246', price: 8500 },
#   { internal_code: '300000247', price: 16_000 },
#   { internal_code: '300000248', price: 37_500 },
#   { internal_code: '300000249', price: 4600 },
#   { internal_code: '300000250', price: 1600 },
#   { internal_code: '300000251', price: 5800 },
#   { internal_code: '300000252', price: 9000 },
#   { internal_code: '300000253', price: 16_800 },
#   { internal_code: '300000254', price: 1600 },
#   { internal_code: '300000255', price: 5800 },
#   { internal_code: '300000256', price: 9000 },
#   { internal_code: '300000257', price: 16_800 },
#   { internal_code: '300000258', price: 2100 },
#   { internal_code: '300000270', price: 32_000 },
#   { internal_code: '300000271', price: 32_000 },
#   { internal_code: '300000272', price: 32_000 },
#   { internal_code: '300000273', price: 11_000 },
#   { internal_code: '300000274', price: 11_000 },
#   { internal_code: '300000275', price: 11_000 },
#   { internal_code: '300000276', price: 38_000 },
#   { internal_code: '300000277', price: 85_000 },
#   { internal_code: '300000332', price: 10_000 },
#   { internal_code: '300000333', price: 10_000 },
#   { internal_code: '300000334', price: 10_000 },
#   { internal_code: '300000335', price: 10_000 },
#   { internal_code: '300000362', price: 3200 },
#   { internal_code: '300000363', price: 3200 },
#   { internal_code: '300000364', price: 3200 },
#   { internal_code: '300000365', price: 3200 },
#   { internal_code: '300000444', price: 40_000 },
#   { internal_code: '300000448', price: 13_800 },
#   { internal_code: '300000453', price: 3500 },
#   { internal_code: '300000477', price: 200_000 },
#   { internal_code: '300000492', price: 32_500 },
#   { internal_code: '300000493', price: 32_500 },
#   { internal_code: '300000494', price: 32_500 },
#   { internal_code: '300000495', price: 74_500 },
#   { internal_code: '300000496', price: 74_500 },
#   { internal_code: '300000497', price: 74_500 },
#   { internal_code: '300000603', price: 4300 },
#   { internal_code: '300000604', price: 4300 },
#   { internal_code: '300000605', price: 4300 },
#   { internal_code: '300000610', price: 12_000 },
#   { internal_code: '300000615', price: 32_000 },
#   { internal_code: '300000616', price: 25_000 },
#   { internal_code: '300000623', price: 46_000 },
#   { internal_code: '300000624', price: 46_000 },
#   { internal_code: '300000625', price: 15_000 },
#   { internal_code: '300000628', price: 43_000 },
#   { internal_code: '300000629', price: 60_000 },
#   { internal_code: '300000656', price: 59_000 },
#   { internal_code: '300000662', price: 160_000 },
#   { internal_code: '300000694', price: 200_000 },
#   { internal_code: '300000707', price: 11_000 },
#   { internal_code: '500000001', price: 7900 },
#   { internal_code: '500000002', price: 10_600 },
#   { internal_code: '500000003', price: 17_000 },
#   { internal_code: '500000004', price: 25_900 },
#   { internal_code: '500000005', price: 10_000 },
#   { internal_code: '500000006', price: 5400 },
#   { internal_code: '500000007', price: 6800 }
# ]
# products_prices.each do |p|
#   ip = InternalProduct.find_by(internal_code: p[:internal_code])
#   if ip.present?
#     ip.price = p[:price]
#     ip.save!
#   end
# end

# Product discount seeders
if AmountDiscount.all.count.zero?
  AmountDiscount.create(
    [
      { min_amount: 20_000, max_amount: 50_000, discount_rate: 10, begin_date: '2019-01-01', end_date: '2050-31-12' },
      { min_amount: 50_001, max_amount: 300_000, discount_rate: 15, begin_date: '2019-01-01', end_date: '2050-31-12' },
      { min_amount: 300_001, max_amount: 500_000, discount_rate: 20, begin_date: '2019-01-01', end_date: '2050-31-12' },
      { min_amount: 500_001, max_amount: 999_999_999, discount_rate: 25, begin_date: '2019-01-01', end_date: '2050-31-12' }
    ]
  )
end
