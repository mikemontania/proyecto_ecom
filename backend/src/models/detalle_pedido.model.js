const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');
const Pedido = require('./pedido.model');
const ProductoInterno = require('./producto_interno.model');

// OrderDetail -> DetallePedido
const DetallePedido = sequelize.define('DetallePedido', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  orderId: { type: DataTypes.BIGINT, allowNull: false }, // order_id
  internalProductId: { type: DataTypes.BIGINT, allowNull: false }, // internal_product_id
}, {
  tableName: 'order_details',
  timestamps: true,
  underscored: true,
});

DetallePedido.belongsTo(Pedido, { foreignKey: 'orderId', targetKey: 'id' });
DetallePedido.belongsTo(ProductoInterno, { foreignKey: 'internalProductId', targetKey: 'id' });

module.exports = DetallePedido;
