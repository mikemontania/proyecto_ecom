module.exports = (sequelize, DataTypes) => {
  const MeasurementUnit = sequelize.define('MeasurementUnit', {
    code: { type: DataTypes.STRING, primaryKey: true },
    name: { type: DataTypes.STRING },
  }, {
    tableName: 'measurement_units',
    timestamps: true,
    underscored: true,
  });
  return MeasurementUnit;
};