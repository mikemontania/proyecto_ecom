module.exports = (sequelize, DataTypes) => {
  const Product = sequelize.define('Product', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name_es: { type: DataTypes.STRING, allowNull: false },
    name_en: { type: DataTypes.STRING },
    name_br: { type: DataTypes.STRING },
    description_es: { type: DataTypes.TEXT },
    description_en: { type: DataTypes.TEXT },
    description_br: { type: DataTypes.TEXT },
    uses_es: { type: DataTypes.TEXT },
    uses_en: { type: DataTypes.TEXT },
    uses_br: { type: DataTypes.TEXT },
    properties_es: { type: DataTypes.TEXT },
    properties_en: { type: DataTypes.TEXT },
    properties_br: { type: DataTypes.TEXT },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
    featured: { type: DataTypes.BOOLEAN, defaultValue: false },
    category_id: { type: DataTypes.INTEGER, allowNull: false },
    subcategory_id: { type: DataTypes.INTEGER, allowNull: false },
    brand_id: { type: DataTypes.INTEGER, allowNull: true },
    order: { type: DataTypes.INTEGER, defaultValue: 0 },
  }, {
    tableName: 'products',
    timestamps: true,
    underscored: true,
  });
  return Product;
};