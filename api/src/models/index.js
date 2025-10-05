const { DataTypes } = require('sequelize');
const { sequelize } = require('../../api/dbconfig');

// Define model factories
const defineCategory = require('./models.category');
const defineSubcategory = require('./models.subcategory');
const defineBrand = require('./models.brand');
const defineProduct = require('./models.product');
const definePresentation = require('./models.presentation');
const defineVariety = require('./models.variety');
const defineInternalProduct = require('./models.internal_product');
const defineMeasurementUnit = require('./models.measurement_unit');
const defineOrder = require('./models.order');
const defineOrderDetail = require('./models.order_detail');
const definePage = require('./models.page');

// Initialize models
const Category = defineCategory(sequelize, DataTypes);
const Subcategory = defineSubcategory(sequelize, DataTypes);
const Brand = defineBrand(sequelize, DataTypes);
const Product = defineProduct(sequelize, DataTypes);
const Presentation = definePresentation(sequelize, DataTypes);
const Variety = defineVariety(sequelize, DataTypes);
const InternalProduct = defineInternalProduct(sequelize, DataTypes);
const MeasurementUnit = defineMeasurementUnit(sequelize, DataTypes);
const Order = defineOrder(sequelize, DataTypes);
const OrderDetail = defineOrderDetail(sequelize, DataTypes);
const Page = definePage(sequelize, DataTypes);

// Associations (Rails-like)
Category.hasMany(Subcategory, { foreignKey: { name: 'category_id', allowNull: false }, onDelete: 'RESTRICT' });
Subcategory.belongsTo(Category, { foreignKey: { name: 'category_id', allowNull: false } });

Category.hasMany(Product, { foreignKey: { name: 'category_id', allowNull: false }, onDelete: 'RESTRICT' });
Product.belongsTo(Category, { foreignKey: { name: 'category_id', allowNull: false } });

Subcategory.hasMany(Product, { foreignKey: { name: 'subcategory_id', allowNull: false }, onDelete: 'RESTRICT' });
Product.belongsTo(Subcategory, { foreignKey: { name: 'subcategory_id', allowNull: false } });

Brand.hasMany(Product, { foreignKey: { name: 'brand_id', allowNull: false }, onDelete: 'RESTRICT' });
Product.belongsTo(Brand, { foreignKey: { name: 'brand_id', allowNull: false } });

Product.hasMany(InternalProduct, { foreignKey: { name: 'product_id', allowNull: false }, onDelete: 'CASCADE' });
InternalProduct.belongsTo(Product, { foreignKey: { name: 'product_id', allowNull: false } });

Presentation.hasMany(InternalProduct, { foreignKey: { name: 'presentation_id', allowNull: false }, onDelete: 'RESTRICT' });
InternalProduct.belongsTo(Presentation, { foreignKey: { name: 'presentation_id', allowNull: false } });

Variety.hasMany(InternalProduct, { foreignKey: { name: 'variety_id', allowNull: false }, onDelete: 'RESTRICT' });
InternalProduct.belongsTo(Variety, { foreignKey: { name: 'variety_id', allowNull: false } });

// measurement_units has PK code and is referenced by internal_products.measurement_unit_code
MeasurementUnit.hasMany(InternalProduct, { foreignKey: { name: 'measurement_unit_code' }, sourceKey: 'code' });
InternalProduct.belongsTo(MeasurementUnit, { foreignKey: { name: 'measurement_unit_code' }, targetKey: 'code' });

Order.hasMany(OrderDetail, { foreignKey: { name: 'order_id', allowNull: false }, onDelete: 'CASCADE' });
OrderDetail.belongsTo(Order, { foreignKey: { name: 'order_id', allowNull: false } });
OrderDetail.belongsTo(InternalProduct, { foreignKey: { name: 'internal_product_id', allowNull: false } });

module.exports = {
  sequelize,
  DataTypes,
  Category,
  Subcategory,
  Brand,
  Product,
  Presentation,
  Variety,
  InternalProduct,
  MeasurementUnit,
  Order,
  OrderDetail,
  Page,
};
