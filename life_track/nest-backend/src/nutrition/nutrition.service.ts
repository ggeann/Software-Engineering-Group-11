import { Injectable } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';

@Injectable()
export class NutritionService {
  constructor(private supabaseService: SupabaseService) {}

  async getDailyNutrition(userId: string, date?: string) {
    const sb = this.supabaseService.getClient();
    const summaryDate = date || new Date().toISOString().split('T')[0];

    const { data, error } = await sb
      .from('daily_summaries')
      .select('*')
      .eq('user_id', userId)
      .eq('summary_date', summaryDate)
      .single();

    if (error && error.code !== 'PGRST116') throw error;

    return data || {
      user_id: userId,
      summary_date: summaryDate,
      total_calories: 0,
      total_protein_g: 0,
      total_carbs_g: 0,
      total_fats_g: 0,
    };
  }

  async getWeeklyNutrition(userId: string) {
    const sb = this.supabaseService.getClient();
    const today = new Date();
    const weekAgo = new Date(today);
    weekAgo.setDate(weekAgo.getDate() - 6);

    const { data, error } = await sb
      .from('daily_summaries')
      .select('*')
      .eq('user_id', userId)
      .gte('summary_date', weekAgo.toISOString().split('T')[0])
      .lte('summary_date', today.toISOString().split('T')[0])
      .order('summary_date', { ascending: true });
    if (error) throw error;
    return data;
  }

  async getNutritionBudget(userId: string, date?: string) {
    const sb = this.supabaseService.getClient();
    const budgetDate = date || new Date().toISOString().split('T')[0];

    const { data: profile, error: profileErr } = await sb
      .from('users_profile')
      .select('*')
      .eq('id', userId)
      .single();

    if (profileErr && profileErr.code !== 'PGRST116') throw profileErr;

    const goalKcal = profile?.daily_calorie_goal || 2100;
    const proteinGoal = profile?.protein_goal_g || 120;
    const carbsGoal = profile?.carbs_goal_g || 250;
    const fatsGoal = profile?.fats_goal_g || 70;

    const { data: logs, error: logsErr } = await sb
      .from('meal_logs')
      .select('calories, protein_g, carbs_g, fats_g')
      .eq('user_id', userId)
      .eq('log_date', budgetDate);
    if (logsErr) throw logsErr;

    const consumed = logs.reduce(
      (acc, log) => ({
        calories: acc.calories + parseFloat(log.calories || '0'),
        protein: acc.protein + parseFloat(log.protein_g || '0'),
        carbs: acc.carbs + parseFloat(log.carbs_g || '0'),
        fats: acc.fats + parseFloat(log.fats_g || '0'),
      }),
      { calories: 0, protein: 0, carbs: 0, fats: 0 },
    );

    return {
      date: budgetDate,
      goal_kcal: goalKcal,
      consumed_kcal: consumed.calories,
      remaining_kcal: Math.max(0, goalKcal - consumed.calories),
      percentage_used: goalKcal > 0 ? +(consumed.calories / goalKcal * 100).toFixed(1) : 0,
      macros: {
        protein: {
          consumed_g: +consumed.protein.toFixed(1),
          goal_g: proteinGoal,
          percentage: proteinGoal > 0 ? +(consumed.protein / proteinGoal * 100).toFixed(1) : 0,
        },
        carbs: {
          consumed_g: +consumed.carbs.toFixed(1),
          goal_g: carbsGoal,
          percentage: carbsGoal > 0 ? +(consumed.carbs / carbsGoal * 100).toFixed(1) : 0,
        },
        fats: {
          consumed_g: +consumed.fats.toFixed(1),
          goal_g: fatsGoal,
          percentage: fatsGoal > 0 ? +(consumed.fats / fatsGoal * 100).toFixed(1) : 0,
        },
      },
    };
  }
}