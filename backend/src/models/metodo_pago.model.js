const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// PaymentMethod -> MetodoPago
const MetodoPago = sequelize.define('MetodoPago', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  name: { type: DataTypes.STRING }, // name
  active: { type: DataTypes.BOOLEAN, defaultValue: true }, // active
  internalName: { type: DataTypes.STRING }, // internal_name
}, {
  tableName: 'payment_methods',
  timestamps: true,
  underscored: true,
});

module.exports = MetodoPago;
