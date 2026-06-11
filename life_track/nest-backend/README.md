# LifeTrack - Nest.js Backend

Backend API untuk aplikasi **LifeTrack** (health & wellness tracker) yang dibangun dengan **Nest.js + Supabase**.

---

## Daftar Isi

1. [Prasyarat](#prasyarat)
2. [Struktur Project](#struktur-project)
3. [Cara Menjalankan (Langkah Demi Langkah)](#cara-menjalankan-langkah-demi-langkah)
   - [1. Clone Repository](#1-clone-repository)
   - [2. Masuk ke Folder Backend](#2-masuk-ke-folder-backend)
   - [3. Install Dependencies](#3-install-dependencies)
   - [4. Setup Environment Variables (.env)](#4-setup-environment-variables-env)
   - [5. Jalankan Backend](#5-jalankan-backend)
   - [6. Verifikasi Backend Jalan](#6-verifikasi-backend-jalan)
4. [Daftar API Endpoint](#daftar-api-endpoint)
   - [Health Check](#health-check)
   - [Food (Makanan)](#food-makanan)
   - [Meals (Catatan Makan)](#meals-catatan-makan)
   - [Nutrition (Nutrisi)](#nutrition-nutrisi)
5. [Autentikasi](#autentikasi)
6. [Testing](#testing)
7. [Teknologi yang Digunakan](#teknologi-yang-digunakan)
8. [Troubleshooting](#troubleshooting)

---

## Prasyarat

| Software | Versi Minimal | Cara Cek |
|----------|---------------|----------|
| **Node.js** | 18.x atau lebih baru | `node -v` |
| **npm** | 9.x atau lebih baru | `npm -v` |
| **Git** | 2.x atau lebih baru | `git --version` |

> Kalau belum ada, download dari [nodejs.org](https://nodejs.org/) (pilih versi LTS).

---

## Struktur Project

```
nest-backend/
├── .env.example                  # Template environment variables (SUDAH DIISI)
├── .gitignore                    # File yang di-exclude dari Git
├── package.json                  # Dependencies & scripts
├── tsconfig.json                 # TypeScript config
├── nest-cli.json                 # NestJS CLI config
├── .prettierrc                   # Prettier config
├── eslint.config.mjs             # ESLint config
├── test/
│   ├── app.e2e-spec.ts           # End-to-end test
│   └── jest-e2e.json             # Jest E2E config
└── src/
    ├── main.ts                   # Entry point (bootstrap, CORS, global prefix)
    ├── app.module.ts             # Root module (import semua module)
    ├── app.controller.ts          # GET /api/v1/health
    ├── app.service.ts             # Health check service
    ├── supabase/
    │   ├── supabase.module.ts     # Global Supabase module
    │   └── supabase.service.ts    # Supabase client (connect ke DB)
    ├── auth/
    │   ├── auth.module.ts         # Auth module
    │   └── auth.guard.ts          # JWT guard (verifikasi token Supabase)
    ├── food/
    │   ├── food.module.ts         # Food module
    │   ├── food.controller.ts     # Endpoint /api/v1/food/*
    │   ├── food.service.ts        # Business logic food
    │   └── dto/
    │       └── create-food.dto.ts # Validasi input create food
    ├── meals/
    │   ├── meals.module.ts
    │   ├── meals.controller.ts    # Endpoint /api/v1/meals/*
    │   ├── meals.service.ts       # Business logic meals
    │   └── dto/
    │       └── create-meal.dto.ts # Validasi input create meal
    └── nutrition/
        ├── nutrition.module.ts
        ├── nutrition.controller.ts # Endpoint /api/v1/nutrition/*
        └── nutrition.service.ts    # Business logic nutrition
```

---

## Cara Menjalankan (Langkah Demi Langkah)

### 1. Clone Repository

Buka **PowerShell** atau **Command Prompt**, lalu:

```bash
git clone https://github.com/ggeann/Software-Engineering-Group-11.git
cd Software-Engineering-Group-11
```

### 2. Masuk ke Folder Backend

```bash
cd life_track\nest-backend
```

### 3. Install Dependencies

```bash
npm install
```

Ini akan meng-install semua package yang dibutuhkan (NestJS, Supabase client, class-validator, dll). Tunggu sampai selesai (biasanya 1-3 menit).

### 4. Setup Environment Variables (.env)

`.env.example` sudah diisi dengan credential asli. Tinggal **copy ke `.env`**:

**Di PowerShell:**
```powershell
Copy-Item .env.example .env
```

**Di Command Prompt:**
```cmd
copy .env.example .env
```

Isi `.env` (ganti dengan credential masing-masing):
```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
PORT=3000
```

### 5. Jalankan Backend

```bash
npm run start:dev
```

Output yang diharapkan:
```
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [NestFactory] Starting Nest application...
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [InstanceLoader] AppModule dependencies initialized
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RoutesResolver] AppController {/api/v1}:
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/health, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RoutesResolver] FoodController {/api/v1/food}:
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/food/search, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/food/barcode/:barcode, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/food/:id, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/food, POST} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RoutesResolver] MealsController {/api/v1/meals}:
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/meals/today, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/meals/date/:date, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/meals/history, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/meals, POST} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/meals/:id, PUT} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/meals/:id, DELETE} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RoutesResolver] NutritionController {/api/v1/nutrition}:
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/nutrition/daily, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/nutrition/weekly, GET} route
[Nest] 12345  - 06/11/2026, 14:00:00     LOG [RouterExplorer] Mapped {/api/v1/nutrition/budget, GET} route
LifeTrack Nest.js API running on port 3000
```

> `npm run start:dev` = **watch mode**. Setiap kamu edit file, backend auto-restart.

### 6. Verifikasi Backend Jalan

Buka browser atau gunakan curl/Postman:

```
GET http://localhost:3000/api/v1/health
```

Response:
```json
{
  "status": "ok"
}
```

---

## Daftar API Endpoint

**Base URL:** `http://localhost:3000/api/v1`

> Semua endpoint (kecuali `/health`) butuh **Authorization header** dengan JWT token dari Supabase Auth.

### Health Check

| Method | Endpoint | Auth | Deskripsi |
|--------|----------|------|-----------|
| `GET` | `/health` | ❌ | Cek server hidup |

Response: `{ "status": "ok" }`

---

### Food (Makanan)

| Method | Endpoint | Auth | Query/Body | Deskripsi |
|--------|----------|------|------------|-----------|
| `GET` | `/food/search` | ✅ | `?q=nasi&limit=20` | Cari makanan (full-text search) |
| `GET` | `/food/search` | ✅ | `?limit=10` | Ambil makanan terbaru (tanpa `q`) |
| `GET` | `/food/barcode/:barcode` | ✅ | - | Cari makanan by barcode |
| `GET` | `/food/:id` | ✅ | - | Detail makanan by ID |
| `POST` | `/food` | ✅ | Body: `CreateFoodDto` | Tambah makanan baru ke database |

**Contoh GET `/food/search?q=ayam&limit=5`:**
```json
{
  "success": true,
  "data": [
    {
      "id": "abc-123",
      "name": "Ayam Goreng",
      "brand": null,
      "serving_size_g": 100,
      "serving_description": "1 potong",
      "calories_per_serving": 250,
      "protein_g": 20,
      "carbs_g": 5,
      "fats_g": 15,
      "fiber_g": 0,
      "sugar_g": 0,
      "sodium_mg": 400,
      "image_url": null,
      "barcode": null,
      "source": "manual"
    }
  ]
}
```

**Contoh POST `/food` (Body JSON):**
```json
{
  "name": "Nasi Putih",
  "serving_size_g": 150,
  "serving_description": "1 piring",
  "calories_per_serving": 194,
  "protein_g": 4,
  "carbs_g": 42,
  "fats_g": 0.5
}
```

---

### Meals (Catatan Makan)

| Method | Endpoint | Auth | Query/Body | Deskripsi |
|--------|----------|------|------------|-----------|
| `GET` | `/meals/today` | ✅ | `?meal_type=breakfast` | Meal log hari ini (opsional filter) |
| `GET` | `/meals/date/:date` | ✅ | `:date` = YYYY-MM-DD | Meal log by tanggal |
| `GET` | `/meals/history` | ✅ | `?from=YYYY-MM-DD&to=YYYY-MM-DD` | Riwayat meal (range) |
| `POST` | `/meals` | ✅ | Body: `CreateMealDto` | Log meal baru |
| `PUT` | `/meals/:id` | ✅ | Body: `{ serving_qty, notes }` | Update meal log |
| `DELETE` | `/meals/:id` | ✅ | - | Hapus meal log |

**Contoh POST `/meals` (Body JSON):**
```json
{
  "food_item_id": "abc-123",
  "meal_type": "lunch",
  "serving_qty": 2,
  "log_date": "2026-06-11",
  "logged_via": "manual"
}
```

**Contoh PUT `/meals/abc-123` (Body JSON):**
```json
{
  "serving_qty": 1.5,
  "notes": "porsi dikurangi"
}
```

---

### Nutrition (Nutrisi)

| Method | Endpoint | Auth | Query | Deskripsi |
|--------|----------|------|-------|-----------|
| `GET` | `/nutrition/daily` | ✅ | `?date=YYYY-MM-DD` | Ringkasan nutrisi harian |
| `GET` | `/nutrition/weekly` | ✅ | - | Ringkasan nutrisi 7 hari terakhir |
| `GET` | `/nutrition/budget` | ✅ | `?date=YYYY-MM-DD` | Budget kalori + realisasi + makro |

**Contoh GET `/nutrition/budget?date=2026-06-11`:**
```json
{
  "success": true,
  "data": {
    "date": "2026-06-11",
    "goal_kcal": 2100,
    "consumed_kcal": 1450,
    "remaining_kcal": 650,
    "percentage_used": 69.0,
    "macros": {
      "protein": { "consumed_g": 85.5, "goal_g": 120, "percentage": 71.3 },
      "carbs":   { "consumed_g": 180.2, "goal_g": 250, "percentage": 72.1 },
      "fats":    { "consumed_g": 45.0, "goal_g": 70, "percentage": 64.3 }
    }
  }
}
```

**Contoh GET `/nutrition/weekly`:**
```json
{
  "success": true,
  "data": [
    { "id": 1, "user_id": "...", "summary_date": "2026-06-05", "total_calories": 1800, "total_protein_g": 95, "total_carbs_g": 210, "total_fats_g": 50 },
    { "id": 2, "user_id": "...", "summary_date": "2026-06-06", "total_calories": 1950, "total_protein_g": 105, "total_carbs_g": 230, "total_fats_g": 55 }
  ]
}
```

---

## Autentikasi

Backend menggunakan **Supabase Auth (JWT)**.

### Cara auth di request:

Setiap request ke endpoint yang butuh auth, sertakan header:

```
Authorization: Bearer <supabase_access_token>
```

Token didapatkan dari Supabase client di **aplikasi Flutter** setelah user login via `supabase.auth.signInWithPassword()`.

### Flow auth:

```
User Login (Flutter)  →  Supabase Auth  →  Dapat accessToken
                                                    ↓
Flutter kirim request  →  Header: "Authorization: Bearer <token>"
                                                    ↓
Nest.js AuthGuard      →  Verifikasi token via supabase.auth.getUser()
                                                    ↓
req.user = user        →  Controller akses req.user.id
```

### Test tanpa auth (untuk development):

Kalau belum setup login di Flutter, bisa **skip auth** sementara dengan **comment/deactivate AuthGuard** di controller. Contoh di `food.controller.ts`:

```typescript
// @UseGuards(AuthGuard)  // <-- comment ini untuk bypass auth
@Controller('food')
export class FoodController { ... }
```

> ⚠️ Jangan lupa di-uncomment lagi sebelum production!

---

## Testing

```bash
# Unit test
npm test

# Test coverage
npm run test:cov

# End-to-end test
npm run test:e2e
```

---

## Teknologi yang Digunakan

| Teknologi | Versi | Fungsi |
|-----------|-------|--------|
| **NestJS** | 11.x | Framework backend (TypeScript) |
| **Supabase JS** | latest | Database + Auth client |
| **TypeScript** | 5.x | Type-safe JavaScript |
| **class-validator** | latest | Validasi DTO input |
| **class-transformer** | latest | Transform input ke class |
| **RxJS** | 7.x | Reactive programming (NestJS core) |
| **Jest** | latest | Unit testing framework |
| **ESLint + Prettier** | latest | Linting & formatting |

---

## Troubleshooting

### Error: `SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY must be set in .env`

**Solusi:** Pastikan file `.env` ada di folder `nest-backend/` dan isinya sudah benar (copy dari `.env.example`).

### Error: `Invalid token` / `Unauthorized`

**Solusi:**
1. Pastikan user sudah login di aplikasi Flutter (token valid)
2. Cek apakah token sudah expired (JWT token Supabase berlaku 1 jam)
3. Untuk development, bisa bypass AuthGuard (lihat [section Autentikasi](#test-tanpa-auth-untuk-development))

### Error: `Connection refused` saat akses API

**Solusi:**
1. Pastikan backend jalan (`npm run start:dev`)
2. Cek port 3000 tidak dipakai aplikasi lain
3. Di `.env`, ganti `PORT=` kalau conflict

### Error: `relation "food_items" does not exist`

**Solusi:** Pastikan tabel `food_items`, `meal_logs`, `daily_summaries`, `users_profile` sudah dibuat di Supabase. Jalankan SQL migration yang ada di Supabase Dashboard.

### Error: `ECONNREFUSED ::1:3000`

**Solusi:** Di `main.ts`, ubah `app.listen(port)` jadi `app.listen(port, '0.0.0.0')` untuk bind ke semua network interface.

### Port 3000 sudah dipakai aplikasi lain?

**Solusi:** Edit `.env`, ganti `PORT=3001` (atau port lain yang kosong). Backend akan jalan di port tersebut.

---

## Menghubungkan dengan Flutter App

Di Flutter app, `FoodApiService` sudah di-set ke `http://localhost:3000/api/v1`. Kalau jalan di **Android Emulator**, ganti `localhost` jadi `10.0.2.2`:

```dart
// Untuk Android Emulator:
static const String _baseUrl = 'http://10.0.2.2:3000/api/v1';

// Untuk iOS Simulator / Web / Physical device (same network):
static const String _baseUrl = 'http://<IP_KOMPUTER>:3000/api/v1';
```

---

## Kontak / Bantuan

Kalau ada masalah atau pertanyaan, buka **Issue** di GitHub repository:
[https://github.com/ggeann/Software-Engineering-Group-11/issues](https://github.com/ggeann/Software-Engineering-Group-11/issues)