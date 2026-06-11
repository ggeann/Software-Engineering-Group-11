import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_type.dart';
import '../providers/food_nutrition_providers.dart';
import '../widgets/food/daily_budget_card.dart';
import '../widgets/food/food_search_bar.dart';
import '../widgets/food/macros_card.dart';
import '../widgets/food/meal_section.dart';
import '../widgets/common/shimmer_loading.dart';
import 'UserDashboardpage.dart';
import 'ActivityNHabit1.dart';
import 'ProgressnAnalyticpage1.dart';
import 'profile.dart';

class FoodNNutritionPage1 extends ConsumerStatefulWidget {
  // Callback navigasi antar fitur utama (Bottom Nav)
  final VoidCallback? onNavigateToDashboard;
  final VoidCallback? onNavigateToActivity;
  final VoidCallback? onNavigateToProgress;
  final VoidCallback? onNavigateToProfile;

  // Callback internal fitur Food & Nutrition (Ke Halaman 2 dan Halaman 3)
  final VoidCallback? onNavigateToSearch; // Menuju Food & Nutrition Page 2 (Tambah Menu)
  final VoidCallback? onNavigateToHistory; // Menuju Food & Nutrition Page 3 (Log/Update Detail)

  const FoodNNutritionPage1({
    super.key,
    this.onNavigateToDashboard,
    this.onNavigateToActivity,
    this.onNavigateToProgress,
    this.onNavigateToProfile,
    this.onNavigateToSearch,
    this.onNavigateToHistory,
  });

  @override
  ConsumerState<FoodNNutritionPage1> createState() => _FoodNNutritionPage1State();
}

class _FoodNNutritionPage1State extends ConsumerState<FoodNNutritionPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  
  // Indeks 1 merepresentasikan halaman "Food" pada susunan Bottom Navigation
  final int _currentNavIndex = 1;

  final List<_NotificationItem> _notifications = [
    _NotificationItem(title: 'Reminder', body: "Don't forget to log your dinner!", time: '5m ago'),
    _NotificationItem(title: 'Goal reached!', body: 'You hit your protein goal today!', time: '1h ago', isRead: true),
    _NotificationItem(title: 'Weekly report', body: 'Your weekly summary is ready.', time: '2h ago', isRead: true),
  ];

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: RefreshIndicator(
                  color: const Color(0xFF0D6E5C),
                  onRefresh: () async {
                    ref.invalidate(dailyBudgetProvider);
                    for (final type in MealType.values) {
                      ref.invalidate(mealLogsProvider(type));
                    }
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _buildBudgetSection(),
                        const SizedBox(height: 8),
                        
                        // AKSI KE PAGE 2: Saat search bar di-tap, jalankan callback navigasi ke pencarian menu
                        FoodSearchBar(
                          onTap: () => widget.onNavigateToSearch?.call(),
                        ),
                        
                        const SizedBox(height: 8),
                        _buildMacrosSection(),
                        const SizedBox(height: 16),
                        
                        // SEKSI BREAKFAST (Memicu Page 2 untuk tambah makanan)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MealSection(
                            mealType: MealType.breakfast,
                            onAddFood: () => widget.onNavigateToSearch?.call(),
                          ),
                        ),
                        
                        // SEKSI LUNCH (Memicu Page 2 untuk tambah makanan)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MealSection(
                            mealType: MealType.lunch,
                            onAddFood: () => widget.onNavigateToSearch?.call(),
                          ),
                        ),
                        
                        // SEKSI DINNER (Memicu Page 2 untuk tambah makanan)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MealSection(
                            mealType: MealType.dinner,
                            onAddFood: () => widget.onNavigateToSearch?.call(),
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        _buildFooter(),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF006B54),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentNavIndex,
        onTap: (index) => _onNavTap(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_rounded),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics_rounded),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetSection() {
    return ref.watch(dailyBudgetProvider).when(
      data: (budget) => DailyBudgetCard(remaining: budget.remainingKcal, goal: budget.goalKcal),
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ShimmerLoading(height: 120, borderRadius: 16),
      ),
      error: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DailyBudgetCard(remaining: 0, goal: 2100),
      ),
    );
  }

  Widget _buildMacrosSection() {
    return ref.watch(dailyBudgetProvider).when(
      data: (budget) {
        final p = budget.macros['protein'];
        final c = budget.macros['carbs'];
        final f = budget.macros['fats'];
        return MacrosCard(
          proteinG: p?.consumedG ?? 84,
          carbsG: c?.consumedG ?? 142,
          fatsG: f?.consumedG ?? 56,
          proteinGoal: p?.goalG ?? 120,
          carbsGoal: c?.goalG ?? 250,
          fatsGoal: f?.goalG ?? 70,
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ShimmerLoading(height: 130, borderRadius: 16),
      ),
      error: (_, __) => const MacrosCard(
        proteinG: 0, carbsG: 0, fatsG: 0,
        proteinGoal: 120, carbsGoal: 250, fatsGoal: 70,
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'images/LifeTrack.png',
                  height: 26,
                  width: 26,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 26,
                    width: 26,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0D6E5C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.track_changes, color: Colors.white, size: 14),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              const Text('LifeTrack',
                  style: TextStyle(fontFamily: 'Georgia', fontWeight: FontWeight.w700,
                      fontSize: 17, color: Color(0xFF111827), letterSpacing: 0.3)),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: _openNotifications,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 34, height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4)],
                      ),
                      child: const Icon(Icons.notifications_none_rounded, size: 18, color: Color(0xFF4A7C6A)),
                    ),
                    if (_unreadCount > 0)
                      Positioned(
                        top: -2, right: -2,
                        child: Container(
                          width: 14, height: 14,
                          decoration: const BoxDecoration(color: Color(0xFFFF6B6B), shape: BoxShape.circle),
                          child: Center(
                            child: Text('$_unreadCount',
                                style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => widget.onNavigateToProfile?.call(),
                child: const CircleAvatar(
                  radius: 17,
                  backgroundColor: Color(0xFF0D6E5C),
                  child: Text('JD', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setLocal) => Container(
          height: MediaQuery.of(context).size.height * 0.55,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(width: 40, height: 4,
                  decoration: BoxDecoration(color: const Color(0xFFDDE8DD), borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notifications',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                  TextButton(
                    onPressed: () {
                      setLocal(() {
                        for (final n in _notifications) n.isRead = true;
                      });
                      setState(() {});
                    },
                    child: const Text('Mark all read', style: TextStyle(fontSize: 12, color: Color(0xFF0D6E5C))),
                  ),
                ],
              ),
              const Divider(color: Color(0xFFEEF3EE)),
              Expanded(
                child: ListView.separated(
                  itemCount: _notifications.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFF4F8F5)),
                  itemBuilder: (_, i) {
                    final n = _notifications[i];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 6),
                      leading: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: n.isRead ? const Color(0xFFF0F5F2) : const Color(0xFFD8F0E5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.notifications_none_rounded,
                            size: 20, color: n.isRead ? const Color(0xFFAABBAA) : const Color(0xFF0D6E5C)),
                      ),
                      title: Text(n.title,
                          style: TextStyle(fontSize: 14, fontWeight: n.isRead ? FontWeight.w400 : FontWeight.w700,
                              color: const Color(0xFF111827))),
                      subtitle: Text(n.body, style: const TextStyle(fontSize: 12, color: Color(0xFF7A9A8A))),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(n.time, style: const TextStyle(fontSize: 10, color: Color(0xFFAABBAA))),
                          if (!n.isRead) ...[
                            const SizedBox(height: 4),
                            Container(width: 8, height: 8,
                                decoration: const BoxDecoration(color: Color(0xFF0D6E5C), shape: BoxShape.circle)),
                          ],
                        ],
                      ),
                      onTap: () {
                        setLocal(() => n.isRead = true);
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Column(
        children: [
          const Text('2026 LifeTrack Wellness. Optimistic health\nfor a better you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Color(0xFFAABBAA))),
          const SizedBox(height: 6),
          Wrap(
            spacing: 12,
            children: ['Privacy', 'Terms', 'Support', 'Blog'].map((t) =>
                GestureDetector(
                  onTap: () {},
                  child: Text(t, style: const TextStyle(fontSize: 11, color: Color(0xFF7AAA8A),
                      decoration: TextDecoration.underline)),
                )).toList(),
          ),
        ],
      ),
    );
  }

  void _onNavTap(int index) {
    if (index == _currentNavIndex) return;

    Widget targetPage;
    switch (index) {
      case 0:
        targetPage = const Userdashboardpage();
        break;
      case 1:
        return;
      case 2:
        targetPage = const ActivityNHabitPage1();
        break;
      case 3:
        targetPage = const Progressnanalyticpage1();
        break;
      case 4:
        targetPage = const Profile();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: const Color(0xFF0D6E5C),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}

class _NotificationItem {
  final String title;
  final String body;
  final String time;
  bool isRead;
  _NotificationItem({required this.title, required this.body, required this.time, this.isRead = false});
}