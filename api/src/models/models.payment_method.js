module.exports = (sequelize, DataTypes) => {
  const PaymentMethod = sequelize.define('PaymentMethod', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name: { type: DataTypes.STRING },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
    internal_name: { type: DataTypes.STRING },
  }, { tableName: 'payment_methods', timestamps: true, underscored: true });
  return PaymentMethod;
};