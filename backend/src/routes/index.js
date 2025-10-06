const { Router } = require('express');
const router = Router();

// Controllers
const categoriaCtrl = require('../controllers/categoria.controller');
const variedadCtrl = require('../controllers/variedad.controller');
const productoCtrl = require('../controllers/producto.controller');

// Rutas
router.get('/categories/:id', categoriaCtrl.getById);
router.get('/varieties/:id', variedadCtrl.getById);
router.get('/products', productoCtrl.list);
router.get('/products/slug/:slug', productoCtrl.getBySlug);

module.exports = router;
