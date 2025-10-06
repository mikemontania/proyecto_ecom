module.exports = (sequelize, DataTypes) => {
  const CartItem = sequelize.define('CartItem', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    shopping_cart_id: { type: DataTypes.INTEGER, allowNull: false },
    internal_product_id: { type: DataTypes.INTEGER, allowNull: false },
    quantity: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 1 },
    unit_price: { type: DataTypes.DECIMAL(14,2), allowNull: false, defaultValue: 0 },
    gross_total: { type: DataTypes.DECIMAL(14,2), allowNull: false, defaultValue: 0 },
    discount_active: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false },
    is_discount_import: { type: DataTypes.BOOLEAN, allowNull: false, defaultValue: false },
    discount_type: { type: DataTypes.STRING },
    discount_rate: { type: DataTypes.DECIMAL(10,2), allowNull: false, defaultValue: 0 },
    discount_amount: { type: DataTypes.DECIMAL(14,2), allowNull: false, defaultValue: 0 },
    net_total: { type: DataTypes.DECIMAL(14,2), allowNull: false, defaultValue: 0 },
  }, { tableName: 'cart_items', timestamps: true, underscored: true });
  return CartItem;
};