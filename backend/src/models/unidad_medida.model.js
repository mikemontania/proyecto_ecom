const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// MeasurementUnit -> UnidadMedida
const UnidadMedida = sequelize.define('UnidadMedida', {
  code: { type: DataTypes.STRING, primaryKey: true, allowNull: false }, // code
  name: { type: DataTypes.STRING }, // name
}, {
  tableName: 'measurement_units',
  timestamps: true,
  underscored: true,
});

module.exports = UnidadMedida;
