const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// ShoppingCart -> Carrito
const Carrito = sequelize.define('Carrito', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  userId: { type: DataTypes.INTEGER }, // user_id
  sessionUuid: { type: DataTypes.UUID }, // session_uuid
  lastOperation: { type: DataTypes.DATE }, // last_operation
  abandoned: { type: DataTypes.BOOLEAN, defaultValue: false }, // abandoned
}, {
  tableName: 'shopping_carts',
  timestamps: true,
  underscored: true,
});

module.exports = Carrito;
