import {
  Controller,
  Get,
  Post,
  Param,
  Query,
  Body,
  Req,
  UseGuards,
} from '@nestjs/common';
import { FoodService } from './food.service';
import { AuthGuard } from '../auth/auth.guard';
import { CreateFoodDto } from './dto/create-food.dto';

@Controller('food')
@UseGuards(AuthGuard)
export class FoodController {
  constructor(private readonly foodService: FoodService) {}

  @Get('search')
  searchFoods(@Query('q') q?: string, @Query('limit') limit?: number) {
    return this.foodService.searchFoods(q, limit ?? 20).then((data) => ({
      success: true,
      data,
    }));
  }

  @Get('barcode/:barcode')
  getFoodByBarcode(@Param('barcode') barcode: string) {
    return this.foodService.getFoodByBarcode(barcode).then((data) => ({
      success: true,
      data,
    }));
  }

  @Get(':id')
  getFoodById(@Param('id') id: string) {
    return this.foodService.getFoodById(id).then((data) => ({
      success: true,
      data,
    }));
  }

  @Post()
  createFood(@Body() dto: CreateFoodDto, @Req() req: any) {
    return this.foodService.createFood(dto, req.user.id).then((data) => ({
      success: true,
      data,
    }));
  }
}