const { DataTypes } = require('sequelize');
const { sequelize } = require('../../dbconfig');

// Order -> Pedido
const Pedido = sequelize.define('Pedido', {
  id: { type: DataTypes.BIGINT, primaryKey: true, autoIncrement: true, allowNull: false },
  status: { type: DataTypes.INTEGER, defaultValue: 0 }, // status
  taxNumber: { type: DataTypes.STRING }, // tax_number
  taxName: { type: DataTypes.STRING }, // tax_name
  total: { type: DataTypes.INTEGER }, // total
  userId: { type: DataTypes.INTEGER }, // user_id
  canceled: { type: DataTypes.BOOLEAN }, // canceled
  paid: { type: DataTypes.BOOLEAN }, // paid
  paymentTransactionId: { type: DataTypes.INTEGER }, // payment_transaction_id
  paymentDate: { type: DataTypes.DATE }, // payment_date
  shippingPhone: { type: DataTypes.STRING }, // shipping_phone
  shippingAddress: { type: DataTypes.STRING }, // shipping_address
  shippingObservation: { type: DataTypes.STRING }, // shipping_observation
  shippingDepartment: { type: DataTypes.STRING }, // shipping_department
  shippingCity: { type: DataTypes.STRING }, // shipping_city
  shippingNeighborhood: { type: DataTypes.STRING }, // shipping_neighborhood
  billingAddress: { type: DataTypes.STRING }, // billing_address
  billingPhone: { type: DataTypes.STRING }, // billing_phone
  billingObservation: { type: DataTypes.STRING }, // billing_observation
  billingDepartment: { type: DataTypes.STRING }, // billing_department
  billingCity: { type: DataTypes.STRING }, // billing_city
  billingNeighborhood: { type: DataTypes.STRING }, // billing_neighborhood
}, {
  tableName: 'orders',
  timestamps: true,
  underscored: true,
});

module.exports = Pedido;
