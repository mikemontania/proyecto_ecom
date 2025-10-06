module.exports = (sequelize, DataTypes) => {
  const Order = sequelize.define('Order', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    status: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
    tax_number: { type: DataTypes.STRING },
    tax_name: { type: DataTypes.STRING },
    total: { type: DataTypes.INTEGER },
    user_id: { type: DataTypes.INTEGER },
    canceled: { type: DataTypes.BOOLEAN },
    paid: { type: DataTypes.BOOLEAN },
    payment_transaction_id: { type: DataTypes.INTEGER },
    payment_date: { type: DataTypes.DATE },
    shipping_phone: { type: DataTypes.STRING },
    shipping_address: { type: DataTypes.STRING },
    shipping_observation: { type: DataTypes.STRING },
    shipping_department: { type: DataTypes.STRING },
    shipping_city: { type: DataTypes.STRING },
    shipping_neighborhood: { type: DataTypes.STRING },
    billing_address: { type: DataTypes.STRING },
    billing_phone: { type: DataTypes.STRING },
    billing_observation: { type: DataTypes.STRING },
    billing_department: { type: DataTypes.STRING },
    billing_city: { type: DataTypes.STRING },
    billing_neighborhood: { type: DataTypes.STRING },
  }, {
    tableName: 'orders',
    timestamps: true,
    underscored: true,
  });
  return Order;
};