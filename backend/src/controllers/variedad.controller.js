const { Op } = require('sequelize');
const Variedad = require('../models/variedad.model');
const { sequelize } = require('../../dbconfig');

// Método para buscar por ID
const getById = async (req, res) => {
  try {
    const { id } = req.params;
    const variedad = await Variedad.findByPk(id);
    if (variedad) {
      res.status(200).json(variedad);
    } else {
      res.status(404).json({ error: 'Variedad no encontrada' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error?.original?.detail || 'Error al buscar la variedad por ID' });
  }
};

module.exports = {
  getById,
};
