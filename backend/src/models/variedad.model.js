const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// Variety -> Variedad
const Variedad = sequelize.define('Variedad', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  nameEs: { type: DataTypes.STRING, allowNull: false }, // name_es
  nameEn: { type: DataTypes.STRING }, // name_en
  nameBr: { type: DataTypes.STRING }, // name_br
  color: { type: DataTypes.STRING }, // color
  icon: { type: DataTypes.STRING }, // icon
  active: { type: DataTypes.BOOLEAN, defaultValue: true, allowNull: false }, // active
}, {
  tableName: 'varieties',
  timestamps: true,
  underscored: true,
});

module.exports = Variedad;
