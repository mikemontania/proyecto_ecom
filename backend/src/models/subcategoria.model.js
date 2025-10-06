const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');
const Categoria = require('./categoria.model');

// Subcategory -> Subcategoria
const Subcategoria = sequelize.define('Subcategoria', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  categoryId: { type: DataTypes.BIGINT, allowNull: false }, // category_id
  nameEs: { type: DataTypes.STRING, allowNull: false }, // name_es
  nameEn: { type: DataTypes.STRING }, // name_en
  nameBr: { type: DataTypes.STRING }, // name_br
  slug: { type: DataTypes.STRING }, // slug
  active: { type: DataTypes.BOOLEAN, defaultValue: true, allowNull: false }, // active
}, {
  tableName: 'subcategories',
  timestamps: true,
  underscored: true,
});

Subcategoria.belongsTo(Categoria, { foreignKey: 'categoryId', targetKey: 'id' });

module.exports = Subcategoria;
