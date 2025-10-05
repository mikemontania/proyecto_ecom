module.exports = (sequelize, DataTypes) => {
  const Category = sequelize.define('Category', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name_es: { type: DataTypes.STRING, allowNull: false },
    name_en: { type: DataTypes.STRING },
    name_br: { type: DataTypes.STRING },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
  }, {
    tableName: 'categories',
    timestamps: true,
    underscored: true,
  });
  return Category;
};