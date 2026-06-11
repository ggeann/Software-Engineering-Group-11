const supabase = require('../config/supabase');

exports.searchFoods = async (req, res) => {
  try {
    const { q, limit = 20 } = req.query;
    let query = supabase.from('food_items').select('*').limit(limit);
    if (q) {
      query = query.textSearch('name', q, { type: 'websearch' });
    }
    const { data, error } = await query;
    if (error) throw error;
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.getFoodById = async (req, res) => {
  try {
    const { data, error } = await supabase.from('food_items').select('*').eq('id', req.params.id).single();
    if (error) throw error;
    if (!data) return res.status(404).json({ success: false, error: 'Food not found' });
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.createFood = async (req, res) => {
  try {
    const { data, error } = await supabase.from('food_items').insert({
      ...req.body,
      created_by: req.user.id,
    }).select().single();
    if (error) throw error;
    res.status(201).json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.getFoodByBarcode = async (req, res) => {
  try {
    const { data, error } = await supabase.from('food_items').select('*').eq('barcode', req.params.barcode).single();
    if (error) throw error;
    if (!data) return res.status(404).json({ success: false, error: 'Barcode not found' });
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};