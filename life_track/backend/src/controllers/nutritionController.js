const supabase = require('../config/supabase');

exports.getDailyNutrition = async (req, res) => {
  try {
    const date = req.query.date || new Date().toISOString().split('T')[0];
    const { data, error } = await supabase
      .from('daily_summaries')
      .select('*')
      .eq('user_id', req.user.id)
      .eq('summary_date', date)
      .single();
    if (error && error.code !== 'PGRST116') throw error;
    res.json({
      success: true,
      data: data || { user_id: req.user.id, summary_date: date, total_calories: 0, total_protein_g: 0, total_carbs_g: 0, total_fats_g: 0 }
    });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.getWeeklyNutrition = async (req, res) => {
  try {
    const today = new Date();
    const weekAgo = new Date(today);
    weekAgo.setDate(weekAgo.getDate() - 6);
    const { data, error } = await supabase
      .from('daily_summaries')
      .select('*')
      .eq('user_id', req.user.id)
      .gte('summary_date', weekAgo.toISOString().split('T')[0])
      .lte('summary_date', today.toISOString().split('T')[0])
      .order('summary_date', { ascending: true });
    if (error) throw error;
    res.json({ success: true, data });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.getNutritionBudget = async (req, res) => {
  try {
    const date = req.query.date || new Date().toISOString().split('T')[0];

    const { data: profile, error: profileErr } = await supabase
      .from('users_profile')
      .select('*')
      .eq('id', req.user.id)
      .single();
    if (profileErr && profileErr.code !== 'PGRST116') throw profileErr;

    const goalKcal = profile?.daily_calorie_goal || 2100;
    const proteinGoal = profile?.protein_goal_g || 120;
    const carbsGoal = profile?.carbs_goal_g || 250;
    const fatsGoal = profile?.fats_goal_g || 70;

    const { data: logs, error: logsErr } = await supabase
      .from('meal_logs')
      .select('calories, protein_g, carbs_g, fats_g')
      .eq('user_id', req.user.id)
      .eq('log_date', date);
    if (logsErr) throw logsErr;

    const consumed = logs.reduce((acc, log) => ({
      calories: acc.calories + parseFloat(log.calories || 0),
      protein: acc.protein + parseFloat(log.protein_g || 0),
      carbs: acc.carbs + parseFloat(log.carbs_g || 0),
      fats: acc.fats + parseFloat(log.fats_g || 0),
    }), { calories: 0, protein: 0, carbs: 0, fats: 0 });

    res.json({
      success: true,
      data: {
        date,
        goal_kcal: goalKcal,
        consumed_kcal: consumed.calories,
        remaining_kcal: Math.max(0, goalKcal - consumed.calories),
        percentage_used: goalKcal > 0 ? +(consumed.calories / goalKcal * 100).toFixed(1) : 0,
        macros: {
          protein: { consumed_g: +consumed.protein.toFixed(1), goal_g: proteinGoal, percentage: proteinGoal > 0 ? +(consumed.protein / proteinGoal * 100).toFixed(1) : 0 },
          carbs:   { consumed_g: +consumed.carbs.toFixed(1), goal_g: carbsGoal, percentage: carbsGoal > 0 ? +(consumed.carbs / carbsGoal * 100).toFixed(1) : 0 },
          fats:    { consumed_g: +consumed.fats.toFixed(1), goal_g: fatsGoal, percentage: fatsGoal > 0 ? +(consumed.fats / fatsGoal * 100).toFixed(1) : 0 },
        },
      },
    });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};