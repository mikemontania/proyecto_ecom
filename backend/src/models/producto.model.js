const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');
const Categoria = require('./categoria.model');
const Subcategoria = require('./subcategoria.model');
const Marca = require('./marca.model');

// Product -> Producto
const Producto = sequelize.define('Producto', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  categoryId: { type: DataTypes.BIGINT, allowNull: false }, // category_id
  subcategoryId: { type: DataTypes.BIGINT, allowNull: false }, // subcategory_id
  brandId: { type: DataTypes.BIGINT, allowNull: false }, // brand_id
  nameEs: { type: DataTypes.STRING, allowNull: false }, // name_es
  nameEn: { type: DataTypes.STRING }, // name_en
  nameBr: { type: DataTypes.STRING }, // name_br
  descriptionEs: { type: DataTypes.TEXT }, // description_es
  descriptionEn: { type: DataTypes.TEXT }, // description_en
  descriptionBr: { type: DataTypes.TEXT }, // description_br
  usesEs: { type: DataTypes.TEXT }, // uses_es
  usesEn: { type: DataTypes.TEXT }, // uses_en
  usesBr: { type: DataTypes.TEXT }, // uses_br
  propertiesEs: { type: DataTypes.TEXT }, // properties_es
  propertiesEn: { type: DataTypes.TEXT }, // properties_en
  propertiesBr: { type: DataTypes.TEXT }, // properties_br
  order: { type: DataTypes.INTEGER, defaultValue: 0 }, // order
  featured: { type: DataTypes.BOOLEAN, defaultValue: false }, // featured
  active: { type: DataTypes.BOOLEAN, defaultValue: true }, // active
  slug: { type: DataTypes.STRING }, // slug
}, {
  tableName: 'products',
  timestamps: true,
  underscored: true,
});

Producto.belongsTo(Categoria, { foreignKey: 'categoryId', targetKey: 'id' });
Producto.belongsTo(Subcategoria, { foreignKey: 'subcategoryId', targetKey: 'id' });
Producto.belongsTo(Marca, { foreignKey: 'brandId', targetKey: 'id' });

module.exports = Producto;
