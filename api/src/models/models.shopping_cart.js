module.exports = (sequelize, DataTypes) => {
  const ShoppingCart = sequelize.define('ShoppingCart', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    user_id: { type: DataTypes.INTEGER },
    session_uuid: { type: DataTypes.STRING },
    last_operation: { type: DataTypes.DATE },
    abandoned: { type: DataTypes.BOOLEAN, defaultValue: false },
  }, { tableName: 'shopping_carts', timestamps: true, underscored: true });
  return ShoppingCart;
};