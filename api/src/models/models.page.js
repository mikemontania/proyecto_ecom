module.exports = (sequelize, DataTypes) => {
  const Page = sequelize.define('Page', {
    id: { type: DataTypes.INTEGER, autoIncrement: true, primaryKey: true },
    title_es: { type: DataTypes.STRING },
    title_en: { type: DataTypes.STRING },
    title_br: { type: DataTypes.STRING },
    content_es: { type: DataTypes.TEXT },
    content_en: { type: DataTypes.TEXT },
    content_br: { type: DataTypes.TEXT },
    icon: { type: DataTypes.STRING },
    order: { type: DataTypes.INTEGER },
    active: { type: DataTypes.BOOLEAN, defaultValue: true },
    slug: { type: DataTypes.STRING, unique: true },
  }, {
    tableName: 'pages',
    timestamps: true,
    underscored: true,
  });
  return Page;
};