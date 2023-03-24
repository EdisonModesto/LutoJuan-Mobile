// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lutojuan/Features/NavBar/RecipeModel.dart';


class IngredientNotifier extends StateNotifier<List<Ingredient>> {
  // We initialize the list of todos to an empty list
  IngredientNotifier(): super([]);


  // Let's allow removing todos
  void removeIngredient(name) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final ingredient in state)
        if (ingredient.name != name) ingredient,
    ];
  }

  void addIngredient(Ingredient ingredient) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [...state, ingredient];
  }
}

// Finally, we are using StateNotifierProvider to allow the UI to interact with
// our TodosNotifier class.
final ingredientProvider = StateNotifierProvider<IngredientNotifier, List<Ingredient>>((ref) {
  return IngredientNotifier();
});