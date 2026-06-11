import { Injectable } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';

@Injectable()
export class MealsService {
  constructor(private supabaseService: SupabaseService) {}

  async getTodayMeals(userId: string) {
    const sb = this.supabaseService.getClient();
    const today = new Date().toISOString().split('T')[0];
    const { data, error } = await sb
      .from('meal_logs')
      .select('*')
      .eq('user_id', userId)
      .eq('log_date', today);
    if (error) throw error;
    return data;
  }

  async getMealsByDate(userId: string, date: string) {
    const sb = this.supabaseService.getClient();
    const { data, error } = await sb
      .from('meal_logs')
      .select('*')
      .eq('user_id', userId)
      .eq('log_date', date);
    if (error) throw error;
    return data;
  }

  async getMealHistory(userId: string, from?: string, to?: string) {
    const sb = this.supabaseService.getClient();
    const today = new Date().toISOString().split('T')[0];
    const { data, error } = await sb
      .from('meal_logs')
      .select('*')
      .eq('user_id', userId)
      .gte('log_date', from || today)
      .lte('log_date', to || today)
      .order('log_date', { ascending: false });
    if (error) throw error;
    return data;
  }

  async createMeal(userId: string, body: {
    food_item_id: string;
    meal_type: string;
    serving_qty?: number;
    log_date?: string;
    logged_via?: string;
  }) {
    const sb = this.supabaseService.getClient();
    const serveQty = body.serving_qty || 1;

    const { data: food, error: foodErr } = await sb
      .from('food_items')
      .select('*')
      .eq('id', body.food_item_id)
      .single();
    if (foodErr) throw foodErr;

    const { data, error } = await sb.from('meal_logs').insert({
      user_id: userId,
      log_date: body.log_date || new Date().toISOString().split('T')[0],
      meal_type: body.meal_type,
      food_item_id: body.food_item_id,
      food_name: food.name,
      serving_qty: serveQty,
      serving_size_g: food.serving_size_g * serveQty,
      calories: food.calories_per_serving * serveQty,
      protein_g: (food.protein_g || 0) * serveQty,
      carbs_g: (food.carbs_g || 0) * serveQty,
      fats_g: (food.fats_g || 0) * serveQty,
      logged_via: body.logged_via || 'manual',
    }).select().single();

    if (error) throw error;
    return data;
  }

  async updateMeal(userId: string, mealId: string, body: { serving_qty?: number; notes?: string }) {
    const sb = this.supabaseService.getClient();
    const updates: any = {};
    if (body.serving_qty != null) updates.serving_qty = body.serving_qty;
    if (body.notes != null) updates.notes = body.notes;

    const { data, error } = await sb
      .from('meal_logs')
      .update(updates)
      .eq('id', mealId)
      .eq('user_id', userId)
      .select()
      .single();
    if (error) throw error;
    return data;
  }

  async deleteMeal(userId: string, mealId: string) {
    const sb = this.supabaseService.getClient();
    const { error } = await sb
      .from('meal_logs')
      .delete()
      .eq('id', mealId)
      .eq('user_id', userId);
    if (error) throw error;
    return { message: 'Meal log deleted' };
  }
}