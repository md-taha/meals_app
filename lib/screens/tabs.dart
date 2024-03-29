// import 'package:flutter/material.dart';
// import 'package:meals_appp/models/meal.dart';
// import 'package:meals_appp/screens/categories.dart';
// import 'package:meals_appp/screens/meals.dart';
// import 'package:meals_appp/screens/filters.dart';
// import 'package:meals_appp/widgets/main_drawer.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals_appp/providers/meals_provider.dart';

// const kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegetarian: false,
//   Filter.vegan: false
// };


// class TabsScreen extends StatefulWidget {
//   const TabsScreen({super.key});

//   @override
//   State<TabsScreen> createState() {
//     return _TabsScreenState();
//   }
// }

// class _TabsScreenState extends State<TabsScreen> {
//   int _selectedPageIndex = 0;
//   final List<Meal> _favoriteMeals = [];
//    Map<Filter, bool> _selectedFilters = kInitialFilters;

//   void _showInfoMessage(String message) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }

//   // void _toggleMealFavoriteStatus(Meal meal) {
//   //   final isExisting = _favoriteMeals.contains(meal);

//   //   if (isExisting) {
//   //     _favoriteMeals.remove(meal);
//   //   } else {
//   //     _favoriteMeals.add(meal);
//   //   }
//   // }

//   void _toggleMealFavoriteStatus(Meal meal) {
//     final isExisting = _favoriteMeals.contains(meal);

//     if (isExisting) {
//       setState(() {
//         _favoriteMeals.remove(meal);
//       });
//       _showInfoMessage('Meal is no longer a favorite.');
//     } else {
//       setState(() {
//         _favoriteMeals.add(meal);
//         _showInfoMessage('Marked as a favorite!');
//       });
//     }
//   }

//   void _selectPage(int index) {
//     setState(() {
//       _selectedPageIndex = index;
//     });
//   }

//   // void _setScreen(String identifier) {
//   //   Navigator.of(context).pop();
//   //   if (identifier == 'filters') {
//   //     Navigator.of(context).push(
//   //       MaterialPageRoute(
//   //         builder: (ctx) => const FiltersScreen(),
//   //       ),
//   //     );
//   //   }
//   // } 

//   void _setScreen(String identifier) async {
//     Navigator.of(context).pop();
//     if (identifier == 'filters') {
//       final result = await Navigator.of(context).push<Map<Filter, bool>>(
//         MaterialPageRoute(
//           builder: (ctx) => FiltersScreen(
//             currentFilters: _selectedFilters,
//           ),
//         ),
//       );

//       setState(() {
//         _selectedFilters = result ?? kInitialFilters;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final meals = ref.watch(mealsProvider);

//     final availableMeals = meals.where((meal) {
//       if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
//         return false;
//       }
//       if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
//         return false;
//       }
//       if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
//         return false;
//       }
//       if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
//         return false;
//       }
//       return true;
//     }).toList();

//      Widget activePage = CategoriesScreen(
//       onToggleFavorite: _toggleMealFavoriteStatus,
//       availableMeals: availableMeals,
//     );
//     var activePageTitle = 'Categories';

//     // if (_selectedPageIndex == 1) {
//     //   activePage = const MealsScreen(meals: []);
//     //   activePageTitle = 'Your Favorites';
//     // }

//     //adding fav icon on meal detail screen
//     if (_selectedPageIndex == 1) {
//       activePage = MealsScreen(
//         meals: _favoriteMeals,
//         onToggleFavorite: _toggleMealFavoriteStatus,
//       );
//       activePageTitle = 'Your Favorites';
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(activePageTitle),
//       ),
//       drawer: MainDrawer(onSelectScreen: _setScreen),
//       body: activePage,
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: _selectPage,
//         currentIndex: _selectedPageIndex,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.set_meal),
//             label: 'Categories',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.star),
//             label: 'Favorites',
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_appp/screens/categories.dart';
import 'package:meals_appp/screens/filters.dart';
import 'package:meals_appp/screens/meals.dart';
import 'package:meals_appp/widgets/main_drawer.dart';
import 'package:meals_appp/providers/meals_provider.dart';
import 'package:meals_appp/providers/favorites_provider.dart';
import 'package:meals_appp/providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];
  // Map<Filter, bool> _selectedFilters = kInitialFilters;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer a favorite.');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Marked as a favorite!');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      // final result = await Navigator.of(context).push<Map<Filter, bool>>(
        await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(
            // currentFilters: _selectedFilters,
          ),
        ),
      );

  //     setState(() {
  //       _selectedFilters = result ?? kInitialFilters;
  //     });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      // if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      //   return false;
      // }
      // if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      //   return false;
      // }
      // if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      //   return false;
      // }
      // if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
      //   return false;
      // }
      if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}