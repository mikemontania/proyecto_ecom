module.exports = (sequelize, DataTypes) => {
  const ProductDiscount = sequelize.define('ProductDiscount', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    internal_product_id: { type: DataTypes.INTEGER, allowNull: false },
    discount_rate: { type: DataTypes.DECIMAL(10, 2), allowNull: false },
    begin_date: { type: DataTypes.DATEONLY, allowNull: false },
    end_date: { type: DataTypes.DATEONLY, allowNull: false },
  }, {
    tableName: 'product_discounts',
    timestamps: true,
    underscored: true,
  });
  return ProductDiscount;
};