import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  /* final String categoryID;
  final String categoryTitle;

  CategoryMealsScreen(this.categoryID,this.categoryTitle);*/
  static const routeName = "/category-meals";

  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeal;
  var _loadedInitData = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData ){
    final routeArgs =
    ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryID = routeArgs["id"];
    categoryTitle = routeArgs["title"];
    displayedMeal = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryID);
    }).toList();
    super.didChangeDependencies();
    _loadedInitData = true;}
  }
  void _removeMeal(String mealId) {
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == mealId);
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeal[index].id,
              title: displayedMeal[index].title,
              imageUrl: displayedMeal[index].imageUrl,
              duration: displayedMeal[index].duration,
              complexity: displayedMeal[index].complexity,
              affordability: displayedMeal[index].affordability,
            );
          },
          itemCount: displayedMeal.length,
        ));
  }
}
