const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// Category -> Categoria
const Categoria = sequelize.define('Categoria', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  nameEs: { type: DataTypes.STRING, allowNull: false }, // name_es
  nameEn: { type: DataTypes.STRING }, // name_en
  nameBr: { type: DataTypes.STRING }, // name_br
  slug: { type: DataTypes.STRING }, // slug
  active: { type: DataTypes.BOOLEAN, defaultValue: true, allowNull: false }, // active
  description: { type: DataTypes.STRING }, // description
  imageUrl: { type: DataTypes.STRING }, // image_url
  displayOrder: { type: DataTypes.INTEGER }, // display_order
}, {
  tableName: 'categories',
  timestamps: true,
  underscored: true,
});

module.exports = Categoria;
