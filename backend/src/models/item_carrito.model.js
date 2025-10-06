const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');
const Carrito = require('./carrito.model');
const ProductoInterno = require('./producto_interno.model');

// CartItem -> ItemCarrito
const ItemCarrito = sequelize.define('ItemCarrito', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  shoppingCartId: { type: DataTypes.BIGINT, allowNull: false }, // shopping_cart_id
  internalProductId: { type: DataTypes.BIGINT, allowNull: false }, // internal_product_id
  quantity: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 1 }, // quantity
  unitPrice: { type: DataTypes.DECIMAL(14,2), allowNull: false, defaultValue: 0 }, // unit_price
  grossTotal: { type: DataTypes.DECIMAL(14,2), allowNull: false, defaultValue: 0 }, // gross_total
  discountActive: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false }, // discount_active
  isDiscountImport: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false }, // is_discount_import
  discountType: { type: DataTypes.STRING }, // discount_type
  discountRate: { type: DataTypes.DECIMAL(10,2), allowNull: false, defaultValue: 0 }, // discount_rate
  discountAmount: { type: DataTypes.DECIMAL(14,2), allowNull: false, defaultValue: 0 }, // discount_amount
  netTotal: { type: DataTypes.DECIMAL(14,2), allowNull: false, defaultValue: 0 }, // net_total
}, {
  tableName: 'cart_items',
  timestamps: true,
  underscored: true,
});

ItemCarrito.belongsTo(Carrito, { foreignKey: 'shoppingCartId', targetKey: 'id' });
ItemCarrito.belongsTo(ProductoInterno, { foreignKey: 'internalProductId', targetKey: 'id' });

module.exports = ItemCarrito;
