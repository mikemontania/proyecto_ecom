const { Router } = require('express');
const ctrl = require('../controllers/cart.controller');
const router = Router();

router.get('/', ctrl.getCart);
router.post('/add', ctrl.addItem);
router.post('/update', ctrl.updateItem);
router.post('/remove', ctrl.removeItem);

module.exports = router;
