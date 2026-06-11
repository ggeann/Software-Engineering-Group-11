const supabase = require('../config/supabase');

exports.getTodayMeals = async (req, res) => {
  try {
    const today = new Date().toISOString().split('T')[0];
    const { data, error } = await supabase
      .from('meal_logs')
      .select('*')
      .eq('user_id', req.user.id)
      .eq('log_date', today);
    if (error) throw error;
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.getMealsByDate = async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('meal_logs')
      .select('*')
      .eq('user_id', req.user.id)
      .eq('log_date', req.params.date);
    if (error) throw error;
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.createMeal = async (req, res) => {
  try {
    const { food_item_id, meal_type, serving_qty, log_date, logged_via } = req.body;

    const { data: food, error: foodErr } = await supabase
      .from('food_items')
      .select('*')
      .eq('id', food_item_id)
      .single();
    if (foodErr) throw foodErr;

    const { data, error } = await supabase.from('meal_logs').insert({
      user_id: req.user.id,
      log_date: log_date || new Date().toISOString().split('T')[0],
      meal_type,
      food_item_id,
      food_name: food.name,
      serving_qty: serving_qty || 1,
      serving_size_g: food.serving_size_g * (serving_qty || 1),
      calories: food.calories_per_serving * (serving_qty || 1),
      protein_g: food.protein_g * (serving_qty || 1),
      carbs_g: food.carbs_g * (serving_qty || 1),
      fats_g: food.fats_g * (serving_qty || 1),
      logged_via: logged_via || 'manual',
    }).select().single();

    if (error) throw error;
    res.status(201).json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.updateMeal = async (req, res) => {
  try {
    const updates = {};
    if (req.body.serving_qty != null) updates.serving_qty = req.body.serving_qty;
    if (req.body.notes != null) updates.notes = req.body.notes;

    const { data, error } = await supabase
      .from('meal_logs')
      .update(updates)
      .eq('id', req.params.id)
      .eq('user_id', req.user.id)
      .select()
      .single();
    if (error) throw error;
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.deleteMeal = async (req, res) => {
  try {
    const { error } = await supabase
      .from('meal_logs')
      .delete()
      .eq('id', req.params.id)
      .eq('user_id', req.user.id);
    if (error) throw error;
    res.json({ success: true, message: 'Meal log deleted' });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.getMealHistory = async (req, res) => {
  try {
    const { from, to } = req.query;
    const today = new Date().toISOString().split('T')[0];
    const query = supabase
      .from('meal_logs')
      .select('*')
      .eq('user_id', req.user.id)
      .gte('log_date', from || today)
      .lte('log_date', to || today)
      .order('log_date', { ascending: false });
    const { data, error } = await query;
    if (error) throw error;
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};