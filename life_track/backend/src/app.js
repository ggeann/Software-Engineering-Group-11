const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.use('/api/v1/food', require('./routes/foodRoutes'));
app.use('/api/v1/meals', require('./routes/mealRoutes'));
app.use('/api/v1/nutrition', require('./routes/nutritionRoutes'));

app.get('/health', (_, res) => res.json({ status: 'ok' }));

app.listen(PORT, () => {
  console.log(`LifeTrack API running on port ${PORT}`);
});