const { Sequelize } = require('sequelize');

const sequelize = new Sequelize(process.env.DB_CNN, {
  logging: false,
});

module.exports = { sequelize };
