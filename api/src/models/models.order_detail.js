module.exports = (sequelize, DataTypes) => {
  const OrderDetail = sequelize.define('OrderDetail', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    order_id: { type: DataTypes.INTEGER, allowNull: false },
    internal_product_id: { type: DataTypes.INTEGER, allowNull: false },
  }, {
    tableName: 'order_details',
    timestamps: true,
    underscored: true,
  });
  return OrderDetail;
};