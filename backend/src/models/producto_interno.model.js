const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');
const Producto = require('./producto.model');
const Presentacion = require('./presentacion.model');
const Variedad = require('./variedad.model');

// InternalProduct -> ProductoInterno
const ProductoInterno = sequelize.define('ProductoInterno', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  productId: { type: DataTypes.BIGINT, allowNull: false }, // product_id
  internalCode: { type: DataTypes.STRING }, // internal_code
  price: { type: DataTypes.DECIMAL(14,2), defaultValue: 0 }, // price
  active: { type: DataTypes.BOOLEAN, defaultValue: true }, // active
  featured: { type: DataTypes.BOOLEAN, defaultValue: false }, // featured
  presentationId: { type: DataTypes.BIGINT, allowNull: false }, // presentation_id
  varietyId: { type: DataTypes.BIGINT, allowNull: false }, // variety_id
  main: { type: DataTypes.BOOLEAN, defaultValue: false }, // main
  image: { type: DataTypes.STRING }, // image
  measurementUnitCode: { type: DataTypes.STRING }, // measurement_unit_code
}, {
  tableName: 'internal_products',
  timestamps: true,
  underscored: true,
});

ProductoInterno.belongsTo(Producto, { foreignKey: 'productId', targetKey: 'id' });
ProductoInterno.belongsTo(Presentacion, { foreignKey: 'presentationId', targetKey: 'id' });
ProductoInterno.belongsTo(Variedad, { foreignKey: 'varietyId', targetKey: 'id' });

module.exports = ProductoInterno;
