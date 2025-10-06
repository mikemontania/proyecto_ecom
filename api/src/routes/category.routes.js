const { Router } = require('express');
const ctrl = require('../controllers/category.controller');
const router = Router();

router.get('/', ctrl.list);
router.get('/slug/:slug', ctrl.show);

module.exports = router;
