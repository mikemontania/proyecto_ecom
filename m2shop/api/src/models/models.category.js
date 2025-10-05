module.exports = (sequelize, DataTypes) => {
  // Category groups products; mirrors Rails Category concept (simplified)
  const Category = sequelize.define(
    'Category',
    {
      id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
      name: { type: DataTypes.STRING(160), allowNull: false },
      slug: { type: DataTypes.STRING(180), allowNull: false, unique: true },
      description: { type: DataTypes.STRING(1000) },
      image_url: { type: DataTypes.STRING(500) },
      display_order: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
      is_active: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: true },
    },
    {
      tableName: 'categories',
      timestamps: true,
      underscored: true,
    }
  );

  return Category;
};
