module.exports = (sequelize, DataTypes) => {
  const Brand = sequelize.define('Brand', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name: { type: DataTypes.STRING, allowNull: false },
    slug: { type: DataTypes.STRING, unique: true },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
    order: { type: DataTypes.INTEGER, defaultValue: 0 },
  }, {
    tableName: 'brands',
    timestamps: true,
    underscored: true,
  });
  return Brand;
};