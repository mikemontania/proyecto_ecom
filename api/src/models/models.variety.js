module.exports = (sequelize, DataTypes) => {
  const Variety = sequelize.define('Variety', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name_es: { type: DataTypes.STRING, allowNull: false },
    name_en: { type: DataTypes.STRING },
    name_br: { type: DataTypes.STRING },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
    icon: { type: DataTypes.STRING },
    color: { type: DataTypes.STRING },
  }, {
    tableName: 'varieties',
    timestamps: true,
    underscored: true,
  });
  return Variety;
};