const { Discount } = require('../models');
const { Op } = require('sequelize');

async function list(_req, res) {
  const today = new Date();
  const items = await Discount.findAll({
    where: {
      start_date: { [Op.lte]: today },
      end_date: { [Op.gte]: today },
    },
    order: [['type', 'ASC'], ['qty_from', 'ASC']],
  });
  res.json(items);
}

module.exports = { list };
