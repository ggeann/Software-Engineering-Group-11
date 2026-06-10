const express = require('express');
const router = express.Router();
const foodController = require('../controllers/foodController');
const auth = require('../middleware/auth');

router.get('/search', auth, foodController.searchFoods);
router.get('/barcode/:barcode', auth, foodController.getFoodByBarcode);
router.get('/:id', auth, foodController.getFoodById);
router.post('/', auth, foodController.createFood);

module.exports = router;