const { Op } = require('sequelize');
const Categoria = require('../models/categoria.model');
const { sequelize } = require('../../dbconfig');

// Método para buscar por ID
const getById = async (req, res) => {
  try {
    const { id } = req.params;
    const categoria = await Categoria.findByPk(id);
    if (categoria) {
      res.status(200).json(categoria);
    } else {
      res.status(404).json({ error: 'Categoría no encontrada' });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error?.original?.detail || 'Error al buscar la categoría por ID' });
  }
};

module.exports = { getById };
