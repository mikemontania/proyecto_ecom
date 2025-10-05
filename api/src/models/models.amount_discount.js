module.exports = (sequelize, DataTypes) => {
  const AmountDiscount = sequelize.define('AmountDiscount', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    min_amount: { type: DataTypes.DECIMAL(14, 2), allowNull: false },
    max_amount: { type: DataTypes.DECIMAL(14, 2), allowNull: false },
    discount_rate: { type: DataTypes.DECIMAL(10, 2), allowNull: false },
    begin_date: { type: DataTypes.DATEONLY, allowNull: false },
    end_date: { type: DataTypes.DATEONLY, allowNull: false },
  }, {
    tableName: 'amount_discounts',
    timestamps: true,
    underscored: true,
  });
  return AmountDiscount;
};