const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// Presentation -> Presentacion
const Presentacion = sequelize.define('Presentacion', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  nameEs: { type: DataTypes.STRING, allowNull: false }, // name_es
  nameEn: { type: DataTypes.STRING }, // name_en
  nameBr: { type: DataTypes.STRING }, // name_br
  size: { type: DataTypes.STRING }, // size
  icon: { type: DataTypes.STRING }, // icon
  active: { type: DataTypes.BOOLEAN, defaultValue: true }, // active
}, {
  tableName: 'presentations',
  timestamps: true,
  underscored: true,
});

module.exports = Presentacion;
