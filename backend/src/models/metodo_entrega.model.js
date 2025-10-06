const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// DeliveryMethod -> MetodoEntrega
const MetodoEntrega = sequelize.define('MetodoEntrega', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  name: { type: DataTypes.STRING }, // name
  active: { type: DataTypes.BOOLEAN, defaultValue: true }, // active
  carryOut: { type: DataTypes.BOOLEAN, defaultValue: false }, // carry_out
}, {
  tableName: 'delivery_methods',
  timestamps: true,
  underscored: true,
});

module.exports = MetodoEntrega;
