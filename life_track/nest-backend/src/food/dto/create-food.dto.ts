import { IsString, IsNumber, IsOptional, IsPositive } from 'class-validator';

export class CreateFoodDto {
  @IsString()
  name: string;

  @IsString()
  @IsOptional()
  brand?: string;

  @IsNumber()
  @IsPositive()
  serving_size_g: number;

  @IsString()
  @IsOptional()
  serving_description?: string;

  @IsNumber()
  @IsPositive()
  calories_per_serving: number;

  @IsNumber()
  @IsOptional()
  protein_g?: number;

  @IsNumber()
  @IsOptional()
  carbs_g?: number;

  @IsNumber()
  @IsOptional()
  fats_g?: number;

  @IsNumber()
  @IsOptional()
  fiber_g?: number;

  @IsNumber()
  @IsOptional()
  sugar_g?: number;

  @IsNumber()
  @IsOptional()
  sodium_mg?: number;

  @IsString()
  @IsOptional()
  image_url?: string;

  @IsString()
  @IsOptional()
  barcode?: string;

  @IsString()
  @IsOptional()
  source?: string;
}