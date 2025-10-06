const { Router } = require('express');
const ctrl = require('../controllers/page.controller');
const router = Router();

router.get('/', ctrl.list);
router.get('/slug/:slug', ctrl.getBySlug);

module.exports = router;
