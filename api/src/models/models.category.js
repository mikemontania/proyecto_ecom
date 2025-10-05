module.exports = (sequelize, DataTypes) => {
  const Category = sequelize.define('Category', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name_es: { type: DataTypes.STRING, allowNull: false },
    name_en: { type: DataTypes.STRING },
    name_br: { type: DataTypes.STRING },
    slug: { type: DataTypes.STRING, unique: true },
    description: { type: DataTypes.STRING },
    image_url: { type: DataTypes.STRING },
    display_order: { type: DataTypes.INTEGER },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
  }, {
    tableName: 'categories',
    timestamps: true,
    underscored: true,
  });
  return Category;
};