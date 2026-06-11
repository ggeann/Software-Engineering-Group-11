import { Controller, Get, Query, Req, UseGuards } from '@nestjs/common';
import { NutritionService } from './nutrition.service';
import { AuthGuard } from '../auth/auth.guard';

@Controller('nutrition')
@UseGuards(AuthGuard)
export class NutritionController {
  constructor(private readonly nutritionService: NutritionService) {}

  @Get('daily')
  getDailyNutrition(@Query('date') date?: string, @Req() req?: any) {
    return this.nutritionService.getDailyNutrition(req.user.id, date).then((data) => ({
      success: true,
      data,
    }));
  }

  @Get('weekly')
  getWeeklyNutrition(@Req() req: any) {
    return this.nutritionService.getWeeklyNutrition(req.user.id).then((data) => ({
      success: true,
      data,
    }));
  }

  @Get('budget')
  getNutritionBudget(@Query('date') date?: string, @Req() req?: any) {
    return this.nutritionService.getNutritionBudget(req.user.id, date).then((data) => ({
      success: true,
      data,
    }));
  }
}