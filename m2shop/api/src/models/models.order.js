module.exports = (sequelize, DataTypes) => {
  // Order header with totals and customer snapshot
  const Order = sequelize.define(
    'Order',
    {
      id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
      customer_id: { type: DataTypes.INTEGER, allowNull: true },
      customer_name: { type: DataTypes.STRING(160), allowNull: false },
      customer_email: { type: DataTypes.STRING(180), allowNull: false },
      customer_phone: { type: DataTypes.STRING(60), allowNull: false },
      shipping_address: { type: DataTypes.STRING(1000), allowNull: false },
      subtotal: { type: DataTypes.DECIMAL(14, 2), allowNull: false, defaultValue: 0 },
      importe_descuento: { type: DataTypes.DECIMAL(14, 2), allowNull: false, defaultValue: 0 },
      porcentaje_descuento: { type: DataTypes.DECIMAL(6, 2), allowNull: false, defaultValue: 0 },
      importe_iva: { type: DataTypes.DECIMAL(14, 2), allowNull: false, defaultValue: 0 },
      total: { type: DataTypes.DECIMAL(14, 2), allowNull: false, defaultValue: 0 },
      status: { type: DataTypes.STRING(40), allowNull: false, defaultValue: 'NEW' },
    },
    {
      tableName: 'orders',
      timestamps: true,
      underscored: true,
    }
  );

  return Order;
};
