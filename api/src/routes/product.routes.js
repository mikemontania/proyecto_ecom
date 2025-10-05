const { Router } = require('express');
const ctrl = require('../controllers/product.controller');
const router = Router();

router.get('/', ctrl.list);
// Place slug route BEFORE numeric id to avoid conflict
router.get('/slug/:slug', ctrl.getBySlug);
router.get('/:id', ctrl.get);
router.post('/', ctrl.create);
router.put('/:id', ctrl.update);
router.delete('/:id', ctrl.remove);

module.exports = router;
