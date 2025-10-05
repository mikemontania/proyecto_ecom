const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// Brand -> Marca
const Marca = sequelize.define('Marca', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  name: { type: DataTypes.STRING, allowNull: false }, // name
  slug: { type: DataTypes.STRING }, // slug
  active: { type: DataTypes.BOOLEAN, defaultValue: true, allowNull: false }, // active
  order: { type: DataTypes.INTEGER }, // order
}, {
  tableName: 'brands',
  timestamps: true,
  underscored: true,
});

module.exports = Marca;
