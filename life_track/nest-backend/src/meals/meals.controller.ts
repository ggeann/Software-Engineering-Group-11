import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Query,
  Body,
  Req,
  UseGuards,
} from '@nestjs/common';
import { MealsService } from './meals.service';
import { AuthGuard } from '../auth/auth.guard';
import { CreateMealDto } from './dto/create-meal.dto';

@Controller('meals')
@UseGuards(AuthGuard)
export class MealsController {
  constructor(private readonly mealsService: MealsService) {}

  @Get('today')
  getTodayMeals(@Req() req: any) {
    return this.mealsService.getTodayMeals(req.user.id).then((data) => ({
      success: true,
      data,
    }));
  }

  @Get('date/:date')
  getMealsByDate(@Param('date') date: string, @Req() req: any) {
    return this.mealsService.getMealsByDate(req.user.id, date).then((data) => ({
      success: true,
      data,
    }));
  }

  @Get('history')
  getMealHistory(
    @Query('from') from?: string,
    @Query('to') to?: string,
    @Req() req?: any,
  ) {
    return this.mealsService.getMealHistory(req.user.id, from, to).then((data) => ({
      success: true,
      data,
    }));
  }

  @Post()
  createMeal(@Body() dto: CreateMealDto, @Req() req: any) {
    return this.mealsService.createMeal(req.user.id, dto).then((data) => ({
      success: true,
      data,
    }));
  }

  @Put(':id')
  updateMeal(
    @Param('id') id: string,
    @Body() body: { serving_qty?: number; notes?: string },
    @Req() req: any,
  ) {
    return this.mealsService.updateMeal(req.user.id, id, body).then((data) => ({
      success: true,
      data,
    }));
  }

  @Delete(':id')
  deleteMeal(@Param('id') id: string, @Req() req: any) {
    return this.mealsService.deleteMeal(req.user.id, id).then((data) => ({
      success: true,
      data,
    }));
  }
}