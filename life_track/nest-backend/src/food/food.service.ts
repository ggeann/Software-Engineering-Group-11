import { Injectable } from '@nestjs/common';
import { SupabaseService } from '../supabase/supabase.service';
import { CreateFoodDto } from './dto/create-food.dto';

@Injectable()
export class FoodService {
  constructor(private supabaseService: SupabaseService) {}

  async searchFoods(q?: string, limit: number = 20) {
    const sb = this.supabaseService.getClient();
    let query = sb.from('food_items').select('*').limit(limit);
    if (q) {
      query = query.textSearch('name', q, { type: 'websearch' });
    }
    const { data, error } = await query;
    if (error) throw error;
    return data;
  }

  async getFoodById(id: string) {
    const sb = this.supabaseService.getClient();
    const { data, error } = await sb.from('food_items').select('*').eq('id', id).single();
    if (error) throw error;
    return data;
  }

  async getFoodByBarcode(barcode: string) {
    const sb = this.supabaseService.getClient();
    const { data, error } = await sb.from('food_items').select('*').eq('barcode', barcode).single();
    if (error) throw error;
    return data;
  }

  async createFood(dto: CreateFoodDto, userId: string) {
    const sb = this.supabaseService.getClient();
    const { data, error } = await sb.from('food_items').insert({
      ...dto,
      created_by: userId,
    }).select().single();
    if (error) throw error;
    return data;
  }
}