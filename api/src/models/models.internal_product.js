module.exports = (sequelize, DataTypes) => {
  const InternalProduct = sequelize.define('InternalProduct', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    product_id: { type: DataTypes.INTEGER, allowNull: false },
    internal_code: { type: DataTypes.STRING },
    price: { type: DataTypes.DECIMAL(14, 2), defaultValue: 0 },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
    featured: { type: DataTypes.BOOLEAN, defaultValue: false },
    presentation_id: { type: DataTypes.INTEGER, allowNull: false },
    variety_id: { type: DataTypes.INTEGER, allowNull: false },
    main: { type: DataTypes.BOOLEAN, defaultValue: false },
    image: { type: DataTypes.STRING },
    measurement_unit_code: { type: DataTypes.STRING },
  }, {
    tableName: 'internal_products',
    timestamps: true,
    underscored: true,
  });
  return InternalProduct;
};