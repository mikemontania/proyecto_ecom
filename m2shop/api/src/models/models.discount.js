module.exports = (sequelize, DataTypes) => {
  // Discount rules: AMOUNT (ranges by cart amount) and PRODUCT (per SKU)
  const Discount = sequelize.define(
    'Discount',
    {
      id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
      type: { type: DataTypes.STRING(20), allowNull: false }, // 'AMOUNT' | 'PRODUCT'
      // AMOUNT range uses qty_from/qty_to to represent total amount ranges (Gs)
      qty_from: { type: DataTypes.DECIMAL(14, 2) },
      qty_to: { type: DataTypes.DECIMAL(14, 2) },
      // PRODUCT rule (specific product) or SKU range
      product_id: { type: DataTypes.INTEGER },
      sku_from: { type: DataTypes.INTEGER },
      sku_to: { type: DataTypes.INTEGER },
      value: { type: DataTypes.DECIMAL(10, 2), allowNull: false }, // percent
      start_date: { type: DataTypes.DATEONLY, allowNull: false },
      end_date: { type: DataTypes.DATEONLY, allowNull: false },
    },
    {
      tableName: 'discounts',
      timestamps: true,
      underscored: true,
    }
  );

  return Discount;
};
