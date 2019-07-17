import 'package:authentication_bloc/src/data/providers/bloc_provider.dart';
import 'package:authentication_bloc/src/models/shopping_item.dart';
import 'package:rxdart/rxdart.dart';


class ShoppingItemBloc implements BlocBase{

  // Stream to notify if the ShoppingItemWidget is part of the shopping basket
  BehaviorSubject<bool> _isInShoppingBasketController = BehaviorSubject<bool>();
  Stream<bool> get isInShoppingBasket => _isInShoppingBasketController;


  // Stream that receives the list of all items, part of the shopping basket
  PublishSubject<List<ShoppingItem>> _shoppingBasketController = PublishSubject<List<ShoppingItem>>();
  Function(List<ShoppingItem>) get shoppingBasket => _shoppingBasketController.sink.add;


  // Constructor with the 'identity' of the shoppingItem
  ShoppingItemBloc(ShoppingItem shoppingItem){

    // Each time a variation of the content of the shopping basket
    _shoppingBasketController.stream
        // We check if this shoppingItem is part of the shopping basket
        .map((list) => list.any((ShoppingItem item) => item.id == shoppingItem.id))
        // if it is part we notify the ShoppingItemWidget
        .listen((isInShoppingBasket) => _isInShoppingBasketController.add(isInShoppingBasket)); // Todo add true
  }


  @override
  void dispose() {

    _isInShoppingBasketController?.close();
    _shoppingBasketController?.close();
  }

}