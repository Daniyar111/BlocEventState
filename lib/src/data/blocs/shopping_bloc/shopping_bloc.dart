import 'dart:math';
import 'dart:ui';

import 'package:authentication_bloc/src/data/providers/bloc_provider.dart';
import 'package:authentication_bloc/src/models/shopping_item.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingBloc implements BlocBase{

  // List of all items, part of the shopping basket
  Set<ShoppingItem> _shoppingBasket = Set<ShoppingItem>();

  ShoppingBloc(){
    _loadShoppingItems();
  }


  // Stream to list of all possible items
  BehaviorSubject<List<ShoppingItem>> _itemsController = BehaviorSubject<List<ShoppingItem>>();
  Stream<List<ShoppingItem>> get items => _itemsController;

  BehaviorSubject<int> _shoppingBasketSizeController = BehaviorSubject<int>();
  Stream<int> get shoppingBasketSize => _shoppingBasketSizeController;

  BehaviorSubject<double> _shoppingBasketPriceController = BehaviorSubject<double>.seeded(0.0);
  Stream<double> get shoppingBasketPrice => _shoppingBasketPriceController;

  // Stream to list the items part of the shopping basket
  BehaviorSubject<List<ShoppingItem>> _shoppingBasketController = BehaviorSubject<List<ShoppingItem>>.seeded(<ShoppingItem>[]);
  Stream<List<ShoppingItem>> get shoppingBasket => _shoppingBasketController;



  void addToShoppingBasket(ShoppingItem item){
    _shoppingBasket.add(item);
    _postActionOnBasket();
  }

  void removeFromShoppingBasket(ShoppingItem item){
    _shoppingBasket.remove(item);
    _postActionOnBasket();
  }



  void _postActionOnBasket(){
    _shoppingBasketController.sink.add(_shoppingBasket.toList());
    _shoppingBasketSizeController.sink.add(_shoppingBasket.length);
    _computeShoppingBasketTotalPrice();
  }

  void _computeShoppingBasketTotalPrice(){
    double total = 0.0;

    _shoppingBasket.forEach((ShoppingItem item){
      total += item.price;
    });

    _shoppingBasketPriceController.sink.add(total);
  }


  // Generates a series of Shopping Items.
  // Normally this should come from a call to the server, but for this sample, we simply simulate

  void _loadShoppingItems(){

    _itemsController.sink.add(List<ShoppingItem>.generate(50, (int index){
      return ShoppingItem(
        id: index,
        title: 'Item $index',
        price: ((Random().nextDouble() * 40.0 + 10.0) * 100.0).roundToDouble() / 100.0,
        color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0)
      );
    }));

  }


  @override
  void dispose() {
    _itemsController?.close();
    _shoppingBasketController?.close();
    _shoppingBasketPriceController?.close();
    _shoppingBasketSizeController?.close();
  }

}