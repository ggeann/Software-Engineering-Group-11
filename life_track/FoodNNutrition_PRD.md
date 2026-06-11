# PRD — Food & Nutrition Module
**Project:** LifeTrack Wellness App
**Stack:** Flutter (Mobile) · Node.js (Backend) · Supabase (Database & Auth)
**Versi PRD:** 1.0.0
**Tanggal:** 2024
**Author:** LifeTrack Product Team

---

## Daftar Isi

1. [Overview & Tujuan](#1-overview--tujuan)
2. [Arsitektur Sistem](#2-arsitektur-sistem)
3. [Supabase Schema](#3-supabase-schema)
4. [Node.js API Endpoints](#4-nodejs-api-endpoints)
5. [FoodNNutritionPage 1 — Main Dashboard](#5-foodnutritionpage-1--main-dashboard)
6. [FoodNNutritionPage 2 — Food Search & Detail](#6-foodnutritionpage-2--food-search--detail)
7. [FoodNNutritionPage 3 — Meal Log & History](#7-foodnutritionpage-3--meal-log--history)
8. [State Management](#8-state-management)
9. [Design Tokens & Theming](#9-design-tokens--theming)
10. [Error Handling & Edge Cases](#10-error-handling--edge-cases)
11. [Testing Checklist](#11-testing-checklist)

---

## 1. Overview & Tujuan

### 1.1 Deskripsi Fitur
Food & Nutrition Module adalah inti dari aplikasi LifeTrack — memungkinkan pengguna untuk:
- Memantau kalori harian dan budget kalori secara real-time
- Log makanan per sesi makan (Breakfast, Lunch, Dinner, Snacks)
- Melihat breakdown makronutrien (Protein, Carbs, Fats)
- Mencari makanan dari database dan scan via QuickScan
- Melihat riwayat makan harian/mingguan

### 1.2 User Persona
- **Nama:** JD (John Doe)
- **Goal:** Menjaga berat badan ideal, target 2.100 kcal/hari
- **Behavior:** Log makan 3x sehari, sering pakai QuickScan untuk makan siang

### 1.3 Struktur Halaman
| Halaman | Nama | Fungsi Utama |
|---------|------|--------------|
| Page 1 | FoodNNutritionPage 1 | Main Dashboard — daily overview, macros, meal sections |
| Page 2 | FoodNNutritionPage 2 | Food Search & Detail — cari makanan, lihat nutrisi detail |
| Page 3 | FoodNNutritionPage 3 | Meal Log & History — histori log makanan, edit, hapus |

---

## 2. Arsitektur Sistem

```
┌─────────────────────────────────────────────┐
│              Flutter App (Mobile)            │
│                                             │
│  FoodNNutritionPage1                        │
│  FoodNNutritionPage2                        │
│  FoodNNutritionPage3                        │
│       │                                     │
│   Riverpod / Provider (State)               │
│       │                                     │
│   FoodApiService (HTTP Client)              │
└──────────────┬──────────────────────────────┘
               │ REST API (HTTPS)
┌──────────────▼──────────────────────────────┐
│         Node.js Backend (Express.js)         │
│                                             │
│   /api/v1/food/*                            │
│   /api/v1/meals/*                           │
│   /api/v1/nutrition/*                       │
│   /api/v1/user/*                            │
│       │                                     │
│   Supabase JS Client                        │
└──────────────┬──────────────────────────────┘
               │
┌──────────────▼──────────────────────────────┐
│               Supabase                       │
│                                             │
│   PostgreSQL Database                       │
│   Auth (JWT)                                │
│   Storage (food images)                     │
│   Realtime (live updates)                   │
└─────────────────────────────────────────────┘
```

### 2.1 Tech Stack Detail
| Layer | Technology | Versi |
|-------|-----------|-------|
| Mobile | Flutter | ≥ 3.19 |
| Language Mobile | Dart | ≥ 3.3 |
| State Management | Riverpod | ≥ 2.5 |
| HTTP Client | Dio | ≥ 5.4 |
| Backend | Node.js | ≥ 20 LTS |
| Framework Backend | Express.js | ≥ 4.18 |
| Database | Supabase (PostgreSQL) | Latest |
| Auth | Supabase Auth | JWT |
| Storage | Supabase Storage | — |
| Charts | fl_chart (Flutter) | ≥ 0.68 |
| Local Cache | Hive / Isar | ≥ 4.0 |

---

## 3. Supabase Schema

### 3.1 Tabel `users_profile`
```sql
CREATE TABLE users_profile (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  daily_calorie_goal INTEGER DEFAULT 2100,
  protein_goal_g INTEGER DEFAULT 120,
  carbs_goal_g INTEGER DEFAULT 250,
  fats_goal_g INTEGER DEFAULT 70,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS Policy
ALTER TABLE users_profile ENABLE ROW LEVEL SECURITY;
CREATE POLICY "User can only access own profile"
  ON users_profile FOR ALL
  USING (auth.uid() = id);
```

### 3.2 Tabel `food_items`
```sql
CREATE TABLE food_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  brand TEXT,
  serving_size_g DECIMAL(8,2) NOT NULL,
  serving_description TEXT, -- e.g. "1 cup", "1 piece"
  calories_per_serving DECIMAL(8,2) NOT NULL,
  protein_g DECIMAL(8,2) DEFAULT 0,
  carbs_g DECIMAL(8,2) DEFAULT 0,
  fats_g DECIMAL(8,2) DEFAULT 0,
  fiber_g DECIMAL(8,2) DEFAULT 0,
  sugar_g DECIMAL(8,2) DEFAULT 0,
  sodium_mg DECIMAL(8,2) DEFAULT 0,
  image_url TEXT,
  barcode TEXT UNIQUE,
  source TEXT DEFAULT 'manual', -- 'manual' | 'quickscan' | 'usda' | 'openfoodfacts'
  is_verified BOOLEAN DEFAULT FALSE,
  created_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_food_items_name ON food_items USING GIN(to_tsvector('english', name));
CREATE INDEX idx_food_items_barcode ON food_items(barcode);
```

### 3.3 Tabel `meal_logs`
```sql
CREATE TABLE meal_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  log_date DATE NOT NULL DEFAULT CURRENT_DATE,
  meal_type TEXT NOT NULL CHECK (meal_type IN ('breakfast', 'lunch', 'dinner', 'snack')),
  food_item_id UUID REFERENCES food_items(id),
  
  -- Snapshot nutrisi saat log (supaya tidak berubah jika food_item diupdate)
  food_name TEXT NOT NULL,
  serving_qty DECIMAL(8,2) DEFAULT 1,
  serving_size_g DECIMAL(8,2) NOT NULL,
  calories DECIMAL(8,2) NOT NULL,
  protein_g DECIMAL(8,2) DEFAULT 0,
  carbs_g DECIMAL(8,2) DEFAULT 0,
  fats_g DECIMAL(8,2) DEFAULT 0,
  
  notes TEXT,
  logged_via TEXT DEFAULT 'manual', -- 'manual' | 'quickscan' | 'voice'
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_meal_logs_user_date ON meal_logs(user_id, log_date);
CREATE INDEX idx_meal_logs_meal_type ON meal_logs(user_id, meal_type, log_date);

-- RLS Policy
ALTER TABLE meal_logs ENABLE ROW LEVEL SECURITY;
CREATE POLICY "User can only access own meal logs"
  ON meal_logs FOR ALL
  USING (auth.uid() = user_id);
```

### 3.4 Tabel `daily_summaries` (Materialized/Cached)
```sql
CREATE TABLE daily_summaries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  summary_date DATE NOT NULL,
  total_calories DECIMAL(8,2) DEFAULT 0,
  total_protein_g DECIMAL(8,2) DEFAULT 0,
  total_carbs_g DECIMAL(8,2) DEFAULT 0,
  total_fats_g DECIMAL(8,2) DEFAULT 0,
  breakfast_calories DECIMAL(8,2) DEFAULT 0,
  lunch_calories DECIMAL(8,2) DEFAULT 0,
  dinner_calories DECIMAL(8,2) DEFAULT 0,
  snack_calories DECIMAL(8,2) DEFAULT 0,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, summary_date)
);

-- Function untuk auto-update daily_summaries
CREATE OR REPLACE FUNCTION update_daily_summary()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO daily_summaries (user_id, summary_date, total_calories, total_protein_g, total_carbs_g, total_fats_g)
  SELECT 
    user_id,
    log_date,
    SUM(calories),
    SUM(protein_g),
    SUM(carbs_g),
    SUM(fats_g)
  FROM meal_logs
  WHERE user_id = COALESCE(NEW.user_id, OLD.user_id)
    AND log_date = COALESCE(NEW.log_date, OLD.log_date)
  GROUP BY user_id, log_date
  ON CONFLICT (user_id, summary_date)
  DO UPDATE SET
    total_calories = EXCLUDED.total_calories,
    total_protein_g = EXCLUDED.total_protein_g,
    total_carbs_g = EXCLUDED.total_carbs_g,
    total_fats_g = EXCLUDED.total_fats_g,
    updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_daily_summary
AFTER INSERT OR UPDATE OR DELETE ON meal_logs
FOR EACH ROW EXECUTE FUNCTION update_daily_summary();
```

---

## 4. Node.js API Endpoints

### 4.1 Struktur Folder Backend
```
backend/
├── src/
│   ├── controllers/
│   │   ├── foodController.js
│   │   ├── mealController.js
│   │   └── nutritionController.js
│   ├── middleware/
│   │   ├── authMiddleware.js
│   │   └── validateMiddleware.js
│   ├── routes/
│   │   ├── foodRoutes.js
│   │   ├── mealRoutes.js
│   │   └── nutritionRoutes.js
│   ├── services/
│   │   ├── supabaseService.js
│   │   └── nutritionCalcService.js
│   └── app.js
├── .env
└── package.json
```

### 4.2 Daftar Endpoint

#### Food Endpoints
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/api/v1/food/search?q={query}&limit={n}` | Search makanan by nama |
| GET | `/api/v1/food/:id` | Get detail food item |
| POST | `/api/v1/food` | Tambah food item baru |
| PUT | `/api/v1/food/:id` | Update food item |
| GET | `/api/v1/food/barcode/:barcode` | Lookup makanan by barcode |

#### Meal Log Endpoints
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/api/v1/meals/today` | Get semua log hari ini per user |
| GET | `/api/v1/meals/date/:date` | Get log by tanggal tertentu (YYYY-MM-DD) |
| POST | `/api/v1/meals` | Tambah log makanan |
| PUT | `/api/v1/meals/:id` | Edit log makanan |
| DELETE | `/api/v1/meals/:id` | Hapus log makanan |
| GET | `/api/v1/meals/history?from={date}&to={date}` | Histori log rentang tanggal |

#### Nutrition Summary Endpoints
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/api/v1/nutrition/daily?date={date}` | Summary nutrisi harian |
| GET | `/api/v1/nutrition/weekly` | Summary nutrisi 7 hari terakhir |
| GET | `/api/v1/nutrition/budget` | Kalori budget & sisa hari ini |

### 4.3 Contoh Request/Response

#### GET `/api/v1/nutrition/budget`
**Response:**
```json
{
  "success": true,
  "data": {
    "date": "2024-01-15",
    "goal_kcal": 2100,
    "consumed_kcal": 460,
    "remaining_kcal": 1640,
    "percentage_used": 21.9,
    "macros": {
      "protein": { "consumed_g": 84, "goal_g": 120, "percentage": 70 },
      "carbs":   { "consumed_g": 142, "goal_g": 250, "percentage": 56.8 },
      "fats":    { "consumed_g": 56, "goal_g": 70, "percentage": 80 }
    }
  }
}
```

#### POST `/api/v1/meals`
**Request Body:**
```json
{
  "food_item_id": "uuid-here",
  "meal_type": "breakfast",
  "serving_qty": 1,
  "log_date": "2024-01-15",
  "logged_via": "manual"
}
```
**Response:**
```json
{
  "success": true,
  "data": {
    "id": "uuid-new-log",
    "food_name": "Greek Yogurt & Berries",
    "meal_type": "breakfast",
    "calories": 220,
    "protein_g": 15,
    "carbs_g": 28,
    "fats_g": 5,
    "created_at": "2024-01-15T07:30:00Z"
  }
}
```

### 4.4 Auth Middleware
```javascript
// middleware/authMiddleware.js
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

const authMiddleware = async (req, res, next) => {
  const token = req.headers.authorization?.replace('Bearer ', '');
  if (!token) return res.status(401).json({ error: 'Unauthorized' });

  const { data: { user }, error } = await supabase.auth.getUser(token);
  if (error || !user) return res.status(401).json({ error: 'Invalid token' });

  req.user = user;
  next();
};

module.exports = authMiddleware;
```

---

## 5. FoodNNutritionPage 1 — Main Dashboard

### 5.1 Deskripsi
Halaman utama yang menjadi "home base" modul makanan. Menampilkan ringkasan kalori harian, progress makronutrien, dan daftar sesi makan beserta item yang sudah di-log.

### 5.2 Wireframe Komponen

```
┌─────────────────────────────────────────┐
│  [AppBar] LifeTrack Logo  🔔  [Avatar]  │
├─────────────────────────────────────────┤
│  ┌───────────────────────────────────┐  │
│  │ Daily Budget Card                  │  │
│  │ 1,640 kcal left    Goal: 2,100    │  │
│  │ ████░░░░░░░░░░░░░░░░░░░░░░░░░░░  │  │
│  └───────────────────────────────────┘  │
│                                         │
│  [SearchBar] 🔍 Search food to log...  │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │ MacrosCard                        │  │
│  │  [DonutChart]   Protein 84/120g   │  │
│  │                 Carbs  142/250g   │  │
│  │  "Macros Today" Fats   56/70g    │  │
│  └──────────────────────────────────┘  │
│                                         │
│  ☀️ Breakfast              340 kcal    │
│  ─────────────────────────────────     │
│  Greek Yogurt & Berries (250g)   220   │
│  Almonds (15g)                   120   │
│  [+ Add Food]                          │
│                                         │
│  🍔 Lunch                  120 kcal    │
│  ─────────────────────────────────     │
│  Grilled Chicken Salad           120   │
│  [+ Add Food]                          │
│                                         │
│  🌙 Dinner                   0 kcal    │
│  ─────────────────────────────────     │
│  ⊕ Log your final meal                 │
│                                         │
│  [BottomNavBar] Dashboard|Food|Activity│
└─────────────────────────────────────────┘
```

### 5.3 Widget Tree (Flutter)

```
FoodNNutritionPage1 (StatefulWidget / ConsumerWidget)
│
├── Scaffold
│   ├── AppBar
│   │   ├── Logo Widget
│   │   ├── IconButton (Bell)
│   │   └── CircleAvatar (JD)
│   │
│   ├── Body: SingleChildScrollView
│   │   ├── DailyBudgetCard
│   │   │   ├── Text "Daily Budget"
│   │   │   ├── RichText "1,640 kcal left"
│   │   │   ├── Text "Goal: 2,100"
│   │   │   └── LinearProgressIndicator (custom)
│   │   │
│   │   ├── FoodSearchBar
│   │   │   └── TextField (onTap → navigate ke Page 2)
│   │   │
│   │   ├── MacrosCard
│   │   │   ├── MacroDonutChart (fl_chart PieChart)
│   │   │   └── MacroLegendColumn
│   │   │       ├── MacroRow("Protein", 84, 120, Color.green)
│   │   │       ├── MacroRow("Carbs", 142, 250, Color.blue)
│   │   │       └── MacroRow("Fats", 56, 70, Color.red)
│   │   │
│   │   ├── MealSection("breakfast", data)
│   │   │   ├── MealSectionHeader(icon, title, totalKcal)
│   │   │   ├── ListView: FoodLogTile (per item)
│   │   │   └── AddFoodButton → navigate ke Page 2
│   │   │
│   │   ├── MealSection("lunch", data)
│   │   │   └── ... (sama seperti breakfast)
│   │   │
│   │   └── MealSection("dinner", data)
│   │       └── LogFinalMealButton (CTA khusus jika kosong)
│   │
│   └── BottomNavigationBar
```

### 5.4 Flutter Code Snippets

#### `DailyBudgetCard`
```dart
class DailyBudgetCard extends StatelessWidget {
  final int remaining;
  final int goal;

  const DailyBudgetCard({
    required this.remaining,
    required this.goal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (remaining / goal);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daily Budget',
              style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${remaining.toStringAsFixed(0)} ',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const TextSpan(
                      text: 'kcal left',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              Text('Goal: ${goal.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  )),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF0D6E5C), // Warna hijau teal LifeTrack
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

#### `MacroDonutChart`
```dart
class MacroDonutChart extends StatelessWidget {
  final double protein;
  final double carbs;
  final double fats;
  final double proteinGoal;
  final double carbsGoal;
  final double fatsGoal;

  const MacroDonutChart({
    required this.protein, required this.carbs, required this.fats,
    required this.proteinGoal, required this.carbsGoal, required this.fatsGoal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: protein,
              color: const Color(0xFF0D6E5C),
              radius: 14,
              showTitle: false,
            ),
            PieChartSectionData(
              value: carbs,
              color: const Color(0xFF3B4A6B),
              radius: 14,
              showTitle: false,
            ),
            PieChartSectionData(
              value: fats,
              color: const Color(0xFFE07070),
              radius: 14,
              showTitle: false,
            ),
            // Sisa yang belum tercapai (abu-abu)
            PieChartSectionData(
              value: (proteinGoal - protein).clamp(0, proteinGoal)
                   + (carbsGoal - carbs).clamp(0, carbsGoal)
                   + (fatsGoal - fats).clamp(0, fatsGoal),
              color: const Color(0xFFE5E7EB),
              radius: 14,
              showTitle: false,
            ),
          ],
          centerSpaceRadius: 40,
          pieTouchData: PieTouchData(enabled: false),
        ),
      ),
    );
  }
}
```

#### `MealSection`
```dart
class MealSection extends ConsumerWidget {
  final MealType mealType;

  const MealSection({required this.mealType, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealLogs = ref.watch(mealLogsProvider(mealType));
    final totalKcal = mealLogs.fold<double>(0, (sum, log) => sum + log.calories);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MealSectionHeader(mealType: mealType, totalKcal: totalKcal),
        if (mealLogs.isEmpty && mealType == MealType.dinner)
          LogFinalMealButton(onTap: () => _navigateToAddFood(context, mealType))
        else ...[
          ...mealLogs.map((log) => FoodLogTile(log: log)),
          AddFoodButton(onTap: () => _navigateToAddFood(context, mealType)),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  void _navigateToAddFood(BuildContext context, MealType type) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FoodNNutritionPage2(targetMealType: type),
      ),
    );
  }
}
```

### 5.5 State Management (Riverpod)

```dart
// providers/food_nutrition_provider.dart

// Provider untuk daily budget
@riverpod
Future<DailyBudget> dailyBudget(DailyBudgetRef ref) async {
  final service = ref.read(foodApiServiceProvider);
  return service.getDailyBudget(date: DateTime.now());
}

// Provider untuk meal logs per meal type
@riverpod
Future<List<MealLog>> mealLogs(MealLogsRef ref, MealType mealType) async {
  final service = ref.read(foodApiServiceProvider);
  final today = DateTime.now();
  return service.getMealLogsByType(date: today, mealType: mealType);
}

// Provider untuk macros hari ini
@riverpod
Future<DailyMacros> dailyMacros(DailyMacrosRef ref) async {
  final service = ref.read(foodApiServiceProvider);
  return service.getDailyMacros(date: DateTime.now());
}
```

### 5.6 Behavior & Interaksi

| Aksi User | Respons Sistem |
|-----------|---------------|
| Tap SearchBar | Navigate ke FoodNNutritionPage2 dengan keyboard langsung muncul |
| Tap "+ Add Food" di Breakfast | Navigate ke Page 2 dengan `targetMealType = breakfast` |
| Tap item makanan (FoodLogTile) | Show BottomSheet detail + opsi edit/hapus |
| Swipe kiri FoodLogTile | Reveal tombol "Delete" dengan konfirmasi |
| Pull to refresh | Refetch semua data dari API |
| Tap "Log your final meal" | Navigate ke Page 2 dengan `targetMealType = dinner` |
| Tap Bell icon | Navigate ke NotificationsPage |
| Tap Avatar | Navigate ke ProfilePage |

### 5.7 Loading & Empty States

- **Loading:** Shimmer skeleton untuk DailyBudgetCard dan MealSection
- **Empty Breakfast/Lunch/Snack:** Tampilkan "+ Add Food" button dengan teks helper "Nothing logged yet"
- **Empty Dinner:** Tampilkan CTA khusus "Log your final meal" dengan icon ⊕
- **Error:** SnackBar merah dengan pesan error + tombol "Retry"

### 5.8 Supabase Realtime (Optional Enhancement)
```dart
// Realtime update jika ada device lain yang log
supabase
  .from('meal_logs')
  .stream(primaryKey: ['id'])
  .eq('user_id', userId)
  .eq('log_date', todayDate)
  .listen((data) {
    ref.invalidate(mealLogsProvider);
    ref.invalidate(dailyBudgetProvider);
  });
```

---

## 6. FoodNNutritionPage 2 — Food Search & Detail

### 6.1 Deskripsi
Halaman pencarian dan pemilihan makanan. Pengguna bisa search by nama, lihat detail nutrisi, set jumlah serving, kemudian log ke sesi makan tertentu.

### 6.2 Wireframe Komponen

```
┌─────────────────────────────────────────┐
│  ← Back    Add to [Breakfast ▼]         │
├─────────────────────────────────────────┤
│  🔍 [Search food...               ] [✕] │
│  [QuickScan 📷] [Recents] [Favorites]   │
├─────────────────────────────────────────┤
│                                         │
│  Recent                                 │
│  ─────────────────────────────────     │
│  🍗 Grilled Chicken Salad               │
│     320 kcal · 1 serving          [+]  │
│  🥛 Greek Yogurt                        │
│     150 kcal · 250g               [+]  │
│                                         │
│  Results for "chicken"                  │
│  ─────────────────────────────────     │
│  🍗 Grilled Chicken Breast              │
│     165 kcal per 100g             [+]  │
│  🍖 Chicken Curry                       │
│     280 kcal per 1 serving        [+]  │
│  ...                                    │
│                                         │
│  [Tap item → Detail Sheet]             │
│  ┌─────────────────────────────────┐   │
│  │ Greek Yogurt & Berries           │   │
│  │ 250g serving                    │   │
│  │ ──────────────────────────────  │   │
│  │ Calories: 220 kcal              │   │
│  │ Protein:  15g    ████░░░░░░     │   │
│  │ Carbs:    28g    ████████░░     │   │
│  │ Fats:      5g    ██░░░░░░░░     │   │
│  │                                 │   │
│  │ Serving: [−] [1 serving] [+]    │   │
│  │                                 │   │
│  │     [Add to Breakfast]          │   │
│  └─────────────────────────────────┘   │
└─────────────────────────────────────────┘
```

### 6.3 Widget Tree (Flutter)

```
FoodNNutritionPage2 (ConsumerStatefulWidget)
│
├── Scaffold
│   ├── AppBar
│   │   ├── BackButton
│   │   ├── MealTypeDropdown (target meal selector)
│   │   └── Title "Add Food"
│   │
│   └── Body: Column
│       ├── SearchBarWidget (auto-focused)
│       │   ├── TextField
│       │   └── ClearButton
│       │
│       ├── FilterChipsRow
│       │   ├── Chip "QuickScan 📷"
│       │   ├── Chip "Recents"
│       │   └── Chip "Favorites"
│       │
│       └── Expanded: SearchResultsBody
│           ├── (jika query kosong) RecentFoodsList
│           ├── (jika query ada) SearchResultsList
│           └── (jika loading) ShimmerList
│
│ [BottomSheet] FoodDetailSheet (saat item di-tap)
│   ├── DragHandle
│   ├── FoodTitle & Brand
│   ├── CalorieBadge
│   ├── NutritionBreakdown (mini bars)
│   ├── ServingSelector (minus/plus/input)
│   ├── NutritionAdjustedValues (update realtime saat serving berubah)
│   └── AddToMealButton (CTA utama)
```

### 6.4 Flutter Code Snippets

#### Search dengan debounce
```dart
class FoodNNutritionPage2 extends ConsumerStatefulWidget {
  final MealType targetMealType;
  const FoodNNutritionPage2({required this.targetMealType, super.key});

  @override
  ConsumerState<FoodNNutritionPage2> createState() => _FoodNNutritionPage2State();
}

class _FoodNNutritionPage2State extends ConsumerState<FoodNNutritionPage2> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      setState(() => _query = _searchController.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(foodSearchProvider(_query));

    return Scaffold(
      appBar: AppBar(
        title: MealTypeDropdown(
          selected: widget.targetMealType,
          onChanged: (type) => setState(() {}),
        ),
      ),
      body: Column(
        children: [
          SearchBarWidget(controller: _searchController),
          FilterChipsRow(onQuickScan: _openQuickScan),
          Expanded(
            child: searchResults.when(
              data: (foods) => _query.isEmpty
                  ? RecentFoodsList(onTap: _showFoodDetail)
                  : FoodResultsList(foods: foods, onTap: _showFoodDetail),
              loading: () => const ShimmerList(),
              error: (e, _) => ErrorView(message: e.toString()),
            ),
          ),
        ],
      ),
    );
  }

  void _showFoodDetail(FoodItem food) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FoodDetailSheet(
        food: food,
        targetMealType: widget.targetMealType,
      ),
    );
  }

  void _openQuickScan() {
    // Navigate ke QuickScan camera page
    Navigator.push(context,
      MaterialPageRoute(builder: (_) => const QuickScanPage()));
  }
}
```

#### `FoodDetailSheet`
```dart
class FoodDetailSheet extends ConsumerStatefulWidget {
  final FoodItem food;
  final MealType targetMealType;
  const FoodDetailSheet({required this.food, required this.targetMealType, super.key});

  @override
  ConsumerState<FoodDetailSheet> createState() => _FoodDetailSheetState();
}

class _FoodDetailSheetState extends ConsumerState<FoodDetailSheet> {
  double _servingQty = 1.0;

  double get _adjustedCalories => widget.food.caloriesPerServing * _servingQty;
  double get _adjustedProtein => widget.food.proteinG * _servingQty;
  double get _adjustedCarbs => widget.food.carbsG * _servingQty;
  double get _adjustedFats => widget.food.fatsG * _servingQty;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const DragHandle(),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.all(20),
                children: [
                  Text(widget.food.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  if (widget.food.brand != null)
                    Text(widget.food.brand!,
                        style: const TextStyle(color: Color(0xFF6B7280))),
                  const SizedBox(height: 16),
                  CalorieBadge(calories: _adjustedCalories),
                  const SizedBox(height: 16),
                  NutritionMiniBar(label: 'Protein', value: _adjustedProtein,
                      goal: 120, color: const Color(0xFF0D6E5C)),
                  NutritionMiniBar(label: 'Carbs', value: _adjustedCarbs,
                      goal: 250, color: const Color(0xFF3B4A6B)),
                  NutritionMiniBar(label: 'Fats', value: _adjustedFats,
                      goal: 70, color: const Color(0xFFE07070)),
                  const SizedBox(height: 20),
                  ServingSelector(
                    qty: _servingQty,
                    label: widget.food.servingDescription ?? '1 serving',
                    onChanged: (qty) => setState(() => _servingQty = qty),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addToMeal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D6E5C),
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Add to ${widget.targetMealType.displayName}',
                      style: const TextStyle(color: Colors.white, fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addToMeal() async {
    final service = ref.read(foodApiServiceProvider);
    try {
      await service.logMeal(
        foodItemId: widget.food.id,
        mealType: widget.targetMealType,
        servingQty: _servingQty,
        logDate: DateTime.now(),
      );
      // Invalidate providers supaya Page 1 refresh
      ref.invalidate(mealLogsProvider(widget.targetMealType));
      ref.invalidate(dailyBudgetProvider);
      if (mounted) {
        Navigator.pop(context); // Tutup sheet
        Navigator.pop(context); // Kembali ke Page 1
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.food.name} added!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}
```

### 6.5 API Provider (Riverpod)

```dart
@riverpod
Future<List<FoodItem>> foodSearch(FoodSearchRef ref, String query) async {
  if (query.isEmpty) return [];
  final service = ref.read(foodApiServiceProvider);
  return service.searchFoods(query: query, limit: 20);
}

@riverpod
Future<List<FoodItem>> recentFoods(RecentFoodsRef ref) async {
  final service = ref.read(foodApiServiceProvider);
  return service.getRecentFoods(limit: 10);
}
```

### 6.6 Behavior & Interaksi

| Aksi User | Respons Sistem |
|-----------|---------------|
| Ketik di search bar | Debounce 400ms → call API search |
| Tap item di hasil | Show FoodDetailSheet via Modal Bottom Sheet |
| Swipe up pada sheet | Expand ke full screen |
| Ubah qty serving | Update nilai kalori & makro secara realtime (lokal) |
| Tap "Add to [Meal]" | POST ke API → invalidate providers → pop ke Page 1 |
| Tap "QuickScan 📷" | Open kamera barcode scanner → auto-fill food |
| Query tidak ditemukan | Tampilkan "Not found" + tombol "Add manually" |
| Tap "Recents" chip | Tampilkan 10 makanan terakhir yang pernah di-log |

---

## 7. FoodNNutritionPage 3 — Meal Log & History

### 7.1 Deskripsi
Halaman riwayat log makanan. Pengguna bisa melihat log per hari (dengan date picker), statistik mingguan, dan mengelola (edit/hapus) log yang sudah ada.

### 7.2 Wireframe Komponen

```
┌─────────────────────────────────────────┐
│  ← Back          History         🗓️    │
├─────────────────────────────────────────┤
│  [ Mon ][ Tue ][ Wed* ][ Thu ][ Fri ]  │
│    11     12    13 ●    14     15       │
│  (Horizontal date strip)               │
├─────────────────────────────────────────┤
│  Wednesday, Jan 15                      │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │  Weekly Summary Chart            │  │
│  │  [Bar chart: kcal per day]       │  │
│  │  Mon Tue Wed Thu Fri Sat Sun      │  │
│  └──────────────────────────────────┘  │
│                                         │
│  Today's Summary                        │
│  Calories: 460 / 2,100 kcal (22%)     │
│  ● Protein  84g  ● Carbs 142g ● Fat 56g│
│                                         │
│  ☀️ Breakfast  340 kcal               │
│  ────────────────────────────────────  │
│  Greek Yogurt & Berries  220 kcal  [✎]│
│  Almonds                 120 kcal  [✎]│
│                                         │
│  🍔 Lunch  120 kcal                   │
│  ────────────────────────────────────  │
│  Grilled Chicken Salad   120 kcal  [✎]│
│                                         │
│  🌙 Dinner  0 kcal                    │
│  No meals logged                        │
└─────────────────────────────────────────┘
```

### 7.3 Widget Tree (Flutter)

```
FoodNNutritionPage3 (ConsumerStatefulWidget)
│
├── Scaffold
│   ├── AppBar
│   │   ├── BackButton
│   │   ├── Title "History"
│   │   └── IconButton (Calendar picker)
│   │
│   └── Body: Column
│       ├── DateStripSelector
│       │   └── HorizontalListView: DateChip × 7
│       │
│       └── Expanded: SingleChildScrollView
│           ├── SelectedDateHeader
│           │
│           ├── WeeklyCalorieBarChart (fl_chart BarChart)
│           │
│           ├── DailySummaryCard
│           │   ├── CalorieProgress
│           │   └── MacroChips Row
│           │
│           ├── HistoryMealSection("breakfast")
│           │   └── HistoryLogTile × n
│           │       ├── FoodName + Kcal
│           │       └── EditIconButton
│           │
│           ├── HistoryMealSection("lunch")
│           ├── HistoryMealSection("dinner")
│           └── HistoryMealSection("snack")
```

### 7.4 Flutter Code Snippets

#### `DateStripSelector`
```dart
class DateStripSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateStripSelector({
    required this.selectedDate,
    required this.onDateSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dates = List.generate(7, (i) =>
      DateTime.now().subtract(Duration(days: 6 - i)));

    return Container(
      height: 72,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: dates.length,
        itemBuilder: (_, i) {
          final date = dates[i];
          final isSelected = date.day == selectedDate.day;
          final isToday = date.day == DateTime.now().day;
          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              width: 48,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0D6E5C) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date).toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? Colors.white : const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                  if (isToday && !isSelected)
                    Container(
                      width: 4, height: 4,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: Color(0xFF0D6E5C),
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

#### `WeeklyCalorieBarChart`
```dart
class WeeklyCalorieBarChart extends StatelessWidget {
  final List<DailySummary> weeklySummaries;
  final int goal;

  const WeeklyCalorieBarChart({
    required this.weeklySummaries,
    required this.goal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          maxY: goal * 1.2,
          gridData: FlGridData(
            show: true,
            horizontalInterval: goal / 4,
            drawVerticalLine: false,
          ),
          barGroups: weeklySummaries.asMap().entries.map((entry) {
            final i = entry.key;
            final summary = entry.value;
            final isOver = summary.totalCalories > goal;
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: summary.totalCalories,
                  color: isOver
                      ? const Color(0xFFE07070)
                      : const Color(0xFF0D6E5C),
                  width: 20,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4)),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) => Text(
                  ['M','T','W','T','F','S','S'][value.toInt()],
                  style: const TextStyle(fontSize: 11,
                      color: Color(0xFF6B7280)),
                ),
              ),
            ),
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }
}
```

#### `HistoryLogTile` dengan edit/delete
```dart
class HistoryLogTile extends ConsumerWidget {
  final MealLog log;

  const HistoryLogTile({required this.log, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: const Color(0xFFEF4444),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => _deleteLog(ref, log.id),
      child: ListTile(
        title: Text(log.foodName,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('${log.servingSizeG.toStringAsFixed(0)}g serving'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${log.calories.toStringAsFixed(0)} kcal',
                style: const TextStyle(color: Color(0xFF6B7280))),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 18,
                  color: Color(0xFF6B7280)),
              onPressed: () => _editLog(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete food log?'),
        content: Text('Remove "${log.foodName}" from your log?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete',
                style: TextStyle(color: Color(0xFFEF4444))),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteLog(WidgetRef ref, String logId) async {
    final service = ref.read(foodApiServiceProvider);
    await service.deleteMealLog(logId);
    ref.invalidate(mealLogsProvider(MealType.fromString(log.mealType)));
    ref.invalidate(dailyBudgetProvider);
  }

  void _editLog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditMealLogSheet(log: log),
    );
  }
}
```

### 7.5 Behavior & Interaksi

| Aksi User | Respons Sistem |
|-----------|---------------|
| Tap date di strip | Fetch log untuk tanggal tersebut |
| Tap icon kalender | Open DatePickerDialog untuk pilih tanggal jauh |
| Swipe kiri pada log tile | Reveal tombol delete + konfirmasi dialog |
| Tap edit (✎) | Open EditMealLogSheet (ubah qty / serving) |
| Tap bar di chart | Highlight tanggal tersebut di date strip |
| Pull to refresh | Refetch history untuk tanggal terpilih |
| Tap tanggal hari ini | Shortcut ke view hari ini |

### 7.6 Provider untuk History

```dart
@riverpod
Future<List<MealLog>> historyMealLogs(
  HistoryMealLogsRef ref,
  DateTime date,
) async {
  final service = ref.read(foodApiServiceProvider);
  return service.getMealLogsByDate(date: date);
}

@riverpod
Future<List<DailySummary>> weeklySummaries(WeeklySummariesRef ref) async {
  final service = ref.read(foodApiServiceProvider);
  final today = DateTime.now();
  final weekAgo = today.subtract(const Duration(days: 6));
  return service.getWeeklySummaries(from: weekAgo, to: today);
}
```

---

## 8. State Management

### 8.1 Provider Structure Overview

```dart
// lib/providers/food_nutrition_providers.dart

// --- Auth ---
@riverpod
SupabaseClient supabase(SupabaseRef ref) => Supabase.instance.client;

@riverpod
FoodApiService foodApiService(FoodApiServiceRef ref) {
  final supabase = ref.watch(supabaseProvider);
  return FoodApiService(supabase: supabase);
}

// --- Page 1 Providers ---
@riverpod
Future<DailyBudget> dailyBudget(DailyBudgetRef ref) async { ... }

@riverpod
Future<DailyMacros> dailyMacros(DailyMacrosRef ref) async { ... }

@riverpod
Future<List<MealLog>> mealLogs(MealLogsRef ref, MealType mealType) async { ... }

// --- Page 2 Providers ---
@riverpod
Future<List<FoodItem>> foodSearch(FoodSearchRef ref, String query) async { ... }

@riverpod
Future<List<FoodItem>> recentFoods(RecentFoodsRef ref) async { ... }

// --- Page 3 Providers ---
@riverpod
Future<List<MealLog>> historyMealLogs(HistoryMealLogsRef ref, DateTime date) async { ... }

@riverpod
Future<List<DailySummary>> weeklySummaries(WeeklySummariesRef ref) async { ... }
```

### 8.2 FoodApiService

```dart
class FoodApiService {
  final Dio _dio;
  final SupabaseClient _supabase;
  static const String _baseUrl = 'https://your-backend.com/api/v1';

  FoodApiService({required SupabaseClient supabase})
      : _supabase = supabase,
        _dio = Dio(BaseOptions(baseUrl: _baseUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final session = _supabase.auth.currentSession;
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        handler.next(options);
      },
    ));
  }

  Future<DailyBudget> getDailyBudget({required DateTime date}) async {
    final response = await _dio.get('/nutrition/budget',
        queryParameters: {'date': DateFormat('yyyy-MM-dd').format(date)});
    return DailyBudget.fromJson(response.data['data']);
  }

  Future<List<FoodItem>> searchFoods({required String query, int limit = 20}) async {
    final response = await _dio.get('/food/search',
        queryParameters: {'q': query, 'limit': limit});
    return (response.data['data'] as List)
        .map((item) => FoodItem.fromJson(item))
        .toList();
  }

  Future<MealLog> logMeal({
    required String foodItemId,
    required MealType mealType,
    required double servingQty,
    required DateTime logDate,
  }) async {
    final response = await _dio.post('/meals', data: {
      'food_item_id': foodItemId,
      'meal_type': mealType.value,
      'serving_qty': servingQty,
      'log_date': DateFormat('yyyy-MM-dd').format(logDate),
      'logged_via': 'manual',
    });
    return MealLog.fromJson(response.data['data']);
  }

  Future<void> deleteMealLog(String logId) async {
    await _dio.delete('/meals/$logId');
  }
}
```

---

## 9. Design Tokens & Theming

### 9.1 Warna (Color Palette)

```dart
// lib/theme/app_colors.dart
class AppColors {
  // Primary
  static const primary = Color(0xFF0D6E5C);        // Teal hijau LifeTrack
  static const primaryLight = Color(0xFFE8F5F2);   // Background ringan
  static const primaryDark = Color(0xFF094D41);

  // Makro
  static const protein = Color(0xFF0D6E5C);   // Hijau
  static const carbs = Color(0xFF3B4A6B);     // Biru navy
  static const fats = Color(0xFFE07070);      // Merah muda

  // Neutral
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const borderColor = Color(0xFFE5E7EB);
  static const background = Color(0xFFF3F4F6);
  static const cardBackground = Color(0xFFFFFFFF);

  // Status
  static const success = Color(0xFF10B981);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);

  // Meal type
  static const breakfast = Color(0xFFFBBF24);  // Kuning
  static const lunch = Color(0xFF3B82F6);       // Biru
  static const dinner = Color(0xFF8B5CF6);      // Ungu
  static const snack = Color(0xFFEC4899);       // Pink
}
```

### 9.2 Typography

```dart
// lib/theme/app_text_styles.dart
class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, letterSpacing: -0.5);

  static const heading2 = TextStyle(
    fontSize: 22, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary);

  static const heading3 = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary);

  static const bodyLarge = TextStyle(
    fontSize: 16, fontWeight: FontWeight.normal,
    color: AppColors.textPrimary);

  static const bodyMedium = TextStyle(
    fontSize: 14, color: AppColors.textPrimary);

  static const caption = TextStyle(
    fontSize: 12, color: AppColors.textSecondary);

  static const calorieBig = TextStyle(
    fontSize: 32, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, letterSpacing: -1.0);
}
```

### 9.3 Spacing & Radius

```dart
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const full = 999.0;
}
```

---

## 10. Error Handling & Edge Cases

### 10.1 Skenario Error

| Skenario | Handling |
|----------|---------|
| Tidak ada koneksi internet | SnackBar offline + load dari local cache (Hive) |
| Token expired | Refresh token otomatis, jika gagal → logout |
| Makanan tidak ditemukan di search | Tampilkan "No results" + opsi tambah manual |
| Barcode QuickScan tidak ada di DB | Tampilkan form "Add New Food" dengan data pre-fill |
| Log gagal tersimpan | Retry otomatis 1x, jika gagal → SnackBar error |
| Kalori melebihi goal | Highlight progress bar merah + notif ringan |
| Data API null/kosong | Gunakan default value 0, jangan crash |
| Tanggal di masa depan di-select | Disable add food, tampilkan "Future date" badge |

### 10.2 Offline Support

```dart
// Simpan daily log ke Hive untuk akses offline
@HiveType(typeId: 0)
class MealLogCache extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String foodName;
  @HiveField(2) double calories;
  @HiveField(3) String mealType;
  @HiveField(4) DateTime logDate;
  // ...
}

// Di FoodApiService
Future<List<MealLog>> getMealLogsByDate({required DateTime date}) async {
  try {
    final response = await _dio.get('/meals/date/${DateFormat('yyyy-MM-dd').format(date)}');
    final logs = (response.data['data'] as List).map(MealLog.fromJson).toList();
    await _cacheService.saveMealLogs(date, logs); // Save ke Hive
    return logs;
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionError) {
      return _cacheService.getMealLogs(date); // Fallback ke cache
    }
    rethrow;
  }
}
```

---

## 11. Testing Checklist

### 11.1 Unit Tests

- [ ] `FoodApiService.searchFoods()` return list yang benar
- [ ] `FoodApiService.logMeal()` mengirim data yang benar ke API
- [ ] `nutritionCalcService.calculateMacros()` akurat untuk berbagai serving qty
- [ ] `DailyBudget.remaining` tidak negatif (clamp ke 0)
- [ ] Provider invalidation setelah add/delete log

### 11.2 Widget Tests

- [ ] `DailyBudgetCard` render kalori sisa dengan benar
- [ ] `MacroDonutChart` menampilkan warna makro yang benar
- [ ] `MealSection` render empty state jika tidak ada log
- [ ] `FoodDetailSheet` update kalori secara realtime saat serving berubah
- [ ] `DateStripSelector` highlight tanggal yang dipilih
- [ ] `HistoryLogTile` swipe dismiss menampilkan konfirmasi dialog

### 11.3 Integration Tests

- [ ] Full flow: Search food → tap item → set serving → add to meal → lihat di Page 1
- [ ] Full flow: Buka Page 3 → tap tanggal berbeda → lihat log berubah
- [ ] Full flow: Swipe delete → confirm → log hilang dari list & kalori terupdate
- [ ] Offline: matikan jaringan → data dari cache tetap tampil
- [ ] Supabase RLS: user A tidak bisa akses log user B

### 11.4 Acceptance Criteria

| Kriteria | Target |
|----------|--------|
| Waktu load Page 1 (dengan cache) | < 300ms |
| Waktu load Page 1 (cold start) | < 1.5 detik |
| Search response time | < 500ms (debounced) |
| Animasi transisi halaman | 60fps |
| Ukuran APK tambahan (module ini) | < 2MB |

---

*PRD ini bersifat living document — update sesuai sprint dan feedback tim.*

**End of PRD — FoodNNutrition Module v1.0.0**
