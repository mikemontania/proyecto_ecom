module.exports = (sequelize, DataTypes) => {
  // Customer for authentication and order ownership
  const Customer = sequelize.define(
    'Customer',
    {
      id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
      firstName: { type: DataTypes.STRING(120), allowNull: false },
      lastName: { type: DataTypes.STRING(120), allowNull: false },
      email: { type: DataTypes.STRING(180), allowNull: false, unique: true },
      phone: { type: DataTypes.STRING(60) },
      password_hash: { type: DataTypes.STRING(255), allowNull: false },
    },
    {
      tableName: 'customers',
      timestamps: true,
      underscored: true,
      defaultScope: {
        attributes: { exclude: ['password_hash'] },
      },
    }
  );

  return Customer;
};
