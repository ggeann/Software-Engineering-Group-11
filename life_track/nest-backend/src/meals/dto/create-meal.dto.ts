import { IsString, IsNumber, IsOptional, IsIn, IsPositive } from 'class-validator';

export class CreateMealDto {
  @IsString()
  food_item_id: string;

  @IsString()
  @IsIn(['breakfast', 'lunch', 'dinner', 'snack'])
  meal_type: string;

  @IsNumber()
  @IsPositive()
  @IsOptional()
  serving_qty?: number;

  @IsString()
  @IsOptional()
  log_date?: string;

  @IsString()
  @IsOptional()
  notes?: string;

  @IsString()
  @IsOptional()
  logged_via?: string;
}