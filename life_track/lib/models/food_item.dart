class FoodItem {
  final String id;
  final String name;
  final String? brand;
  final double servingSizeG;
  final String? servingDescription;
  final double caloriesPerServing;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final double fiberG;
  final double sugarG;
  final double sodiumMg;
  final String? imageUrl;
  final String? barcode;
  final String source;

  const FoodItem({
    required this.id,
    required this.name,
    this.brand,
    required this.servingSizeG,
    this.servingDescription,
    required this.caloriesPerServing,
    this.proteinG = 0,
    this.carbsG = 0,
    this.fatsG = 0,
    this.fiberG = 0,
    this.sugarG = 0,
    this.sodiumMg = 0,
    this.imageUrl,
    this.barcode,
    this.source = 'manual',
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
        id: json['id'] as String,
        name: json['name'] as String,
        brand: json['brand'] as String?,
        servingSizeG: (json['serving_size_g'] as num).toDouble(),
        servingDescription: json['serving_description'] as String?,
        caloriesPerServing: (json['calories_per_serving'] as num).toDouble(),
        proteinG: (json['protein_g'] as num?)?.toDouble() ?? 0,
        carbsG: (json['carbs_g'] as num?)?.toDouble() ?? 0,
        fatsG: (json['fats_g'] as num?)?.toDouble() ?? 0,
        fiberG: (json['fiber_g'] as num?)?.toDouble() ?? 0,
        sugarG: (json['sugar_g'] as num?)?.toDouble() ?? 0,
        sodiumMg: (json['sodium_mg'] as num?)?.toDouble() ?? 0,
        imageUrl: json['image_url'] as String?,
        barcode: json['barcode'] as String?,
        source: json['source'] as String? ?? 'manual',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brand': brand,
        'serving_size_g': servingSizeG,
        'serving_description': servingDescription,
        'calories_per_serving': caloriesPerServing,
        'protein_g': proteinG,
        'carbs_g': carbsG,
        'fats_g': fatsG,
        'fiber_g': fiberG,
        'sugar_g': sugarG,
        'sodium_mg': sodiumMg,
        'image_url': imageUrl,
        'barcode': barcode,
        'source': source,
      };
}