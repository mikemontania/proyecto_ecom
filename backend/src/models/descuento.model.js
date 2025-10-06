const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// Discount unify Amount/Product discounts -> Descuento
const Descuento = sequelize.define('Descuento', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  type: { type: DataTypes.STRING(20), allowNull: false }, // 'AMOUNT' | 'PRODUCT'
  qtyFrom: { type: DataTypes.DECIMAL(14,2) }, // qty_from (amount-from or min quantity)
  qtyTo: { type: DataTypes.DECIMAL(14,2) }, // qty_to (amount-to or max quantity)
  productId: { type: DataTypes.BIGINT }, // product_id
  skuFrom: { type: DataTypes.BIGINT }, // sku_from
  skuTo: { type: DataTypes.BIGINT }, // sku_to
  value: { type: DataTypes.DECIMAL(10,2), allowNull: false }, // percent
  startDate: { type: DataTypes.DATEONLY, allowNull: false }, // start_date
  endDate: { type: DataTypes.DATEONLY, allowNull: false }, // end_date
}, {
  tableName: 'discounts',
  timestamps: true,
  underscored: true,
});

module.exports = Descuento;
