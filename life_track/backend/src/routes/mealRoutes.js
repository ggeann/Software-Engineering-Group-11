const express = require('express');
const router = express.Router();
const mealController = require('../controllers/mealController');
const auth = require('../middleware/auth');

router.get('/today', auth, mealController.getTodayMeals);
router.get('/date/:date', auth, mealController.getMealsByDate);
router.get('/history', auth, mealController.getMealHistory);
router.post('/', auth, mealController.createMeal);
router.put('/:id', auth, mealController.updateMeal);
router.delete('/:id', auth, mealController.deleteMeal);

module.exports = router;