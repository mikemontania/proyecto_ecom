module.exports = (sequelize, DataTypes) => {
  const DeliveryMethod = sequelize.define('DeliveryMethod', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    name: { type: DataTypes.STRING },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
    carry_out: { type: DataTypes.BOOLEAN, defaultValue: false },
  }, { tableName: 'delivery_methods', timestamps: true, underscored: true });
  return DeliveryMethod;
};