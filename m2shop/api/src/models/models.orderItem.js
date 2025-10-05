module.exports = (sequelize, DataTypes) => {
  // Order line item (join with extra fields)
  const OrderItem = sequelize.define(
    'OrderItem',
    {
      id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
      order_id: { type: DataTypes.INTEGER, allowNull: false },
      product_id: { type: DataTypes.INTEGER, allowNull: false },
      quantity: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 1 },
      unit_price: { type: DataTypes.DECIMAL(14, 2), allowNull: false, defaultValue: 0 },
      line_total: { type: DataTypes.DECIMAL(14, 2), allowNull: false, defaultValue: 0 },
    },
    {
      tableName: 'order_items',
      timestamps: true,
      underscored: true,
    }
  );

  return OrderItem;
};
