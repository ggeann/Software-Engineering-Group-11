const express = require('express');
const router = express.Router();
const nutritionController = require('../controllers/nutritionController');
const auth = require('../middleware/auth');

router.get('/daily', auth, nutritionController.getDailyNutrition);
router.get('/weekly', auth, nutritionController.getWeeklyNutrition);
router.get('/budget', auth, nutritionController.getNutritionBudget);

module.exports = router;