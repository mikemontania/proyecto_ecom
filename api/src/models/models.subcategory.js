module.exports = (sequelize, DataTypes) => {
  const Subcategory = sequelize.define('Subcategory', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name_es: { type: DataTypes.STRING, allowNull: false },
    name_en: { type: DataTypes.STRING },
    name_br: { type: DataTypes.STRING },
    slug: { type: DataTypes.STRING, unique: true },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
    category_id: { type: DataTypes.INTEGER, allowNull: false },
  }, {
    tableName: 'subcategories',
    timestamps: true,
    underscored: true,
  });
  return Subcategory;
};