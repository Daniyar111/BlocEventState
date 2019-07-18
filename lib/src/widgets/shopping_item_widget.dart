import 'dart:async';

import 'package:authentication_bloc/src/data/blocs/shopping_bloc/shopping_bloc.dart';
import 'package:authentication_bloc/src/data/blocs/shopping_bloc/shopping_item_bloc.dart';
import 'package:authentication_bloc/src/data/providers/bloc_provider.dart';
import 'package:authentication_bloc/src/models/shopping_item.dart';
import 'package:flutter/material.dart';

class ShoppingItemWidget extends StatefulWidget {

  final ShoppingItem shoppingItem;

  ShoppingItemWidget({
    Key key,
    @required this.shoppingItem
  }) : super(key: key);

  @override
  _ShoppingItemWidgetState createState() => _ShoppingItemWidgetState();
}

class _ShoppingItemWidgetState extends State<ShoppingItemWidget> {

  StreamSubscription _subscription;
  ShoppingItemBloc _bloc;
  ShoppingBloc _shoppingBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print('Shopping item widget didChangeDependencies');
    // As the context should not be used in the "initState()" method,
    // prefer using the "didChangeDependencies()" when you need
    // to refer to the context at initialization time
    _initBloc();
  }

  @override
  void didUpdateWidget(ShoppingItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    print('Shopping item widget didUpdateWidget');
    // as Flutter might decide to reorganize the Widgets tree
    // it is preferable to recreate the links
    _disposeBloc();
    _initBloc();
  }


  // This routine is reponsible for creating the links
  void _initBloc() {
    // Create an instance of the ShoppingItemBloc
    _bloc = ShoppingItemBloc(widget.shoppingItem);

    // Retrieve the BLoC that handles the Shopping Basket content
    _shoppingBloc = BlocProvider.of<ShoppingBloc>(context);

    // Simple pipe that transfers the content of the shopping
    // basket to the ShoppingItemBloc
    _subscription = _shoppingBloc.shoppingBasket.listen(_bloc.shoppingBasket);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridTile(
        header: Center(
          child: Text(widget.shoppingItem.title),
        ),
        footer: Center(
          child: Text('${widget.shoppingItem.price} €'),
        ),
        child: Container(
          color: widget.shoppingItem.color,
          child: Center(
            child: _buildButton(),
          ),
        ),
      ),
    );
  }


  Widget _buildButton() {
    return StreamBuilder<bool>(
      stream: _bloc.isInShoppingBasket,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return snapshot.data
            ? _buildRemoveFromShoppingBasket()
            : _buildAddToShoppingBasket();
      },
    );
  }

  Widget _buildAddToShoppingBasket(){
    return RaisedButton(
      child: Text('Add...'),
      onPressed: (){
        _shoppingBloc.addToShoppingBasket(widget.shoppingItem);
      },
    );
  }

  Widget _buildRemoveFromShoppingBasket(){
    return RaisedButton(
      child: Text('Remove...'),
      onPressed: (){
        _shoppingBloc.removeFromShoppingBasket(widget.shoppingItem);
      },
    );
  }



  void _disposeBloc() {
    _subscription?.cancel();
    _bloc?.dispose();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }
}
