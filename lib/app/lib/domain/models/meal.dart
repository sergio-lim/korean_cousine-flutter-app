class Meal {
  final String? id;
  final List<String>? categories;
  final String? title;
  final String? imageUrl;
  final List<String>? ingredients;
  final List<String>? steps;
  final String? duration;
  final String? complexity;
  final String? affordability;
  final bool? isCheap;
  final bool? isSimple;
  final bool? isFast;
  final bool? isSpicy;

  const Meal({
    this.isCheap,
    this.isSimple,
    this.isFast,
    this.id,
    this.categories,
    this.title,
    this.imageUrl,
    this.ingredients,
    this.steps,
    this.duration,
    this.complexity,
    this.affordability,
    this.isSpicy,
  });
}
