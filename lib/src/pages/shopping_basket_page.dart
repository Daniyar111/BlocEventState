import 'package:authentication_bloc/src/data/blocs/shopping_bloc/shopping_bloc.dart';
import 'package:authentication_bloc/src/data/providers/bloc_provider.dart';
import 'package:authentication_bloc/src/models/shopping_item.dart';
import 'package:authentication_bloc/src/widgets/shopping_item_widget.dart';
import 'package:flutter/material.dart';

class ShoppingBasketPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ShoppingBloc shoppingBloc = BlocProvider.of<ShoppingBloc>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Shopping Basket'),
        ),
        body: Container(
          child: StreamBuilder<List<ShoppingItem>>(
            stream: shoppingBloc.shoppingBasket,
            builder: (BuildContext context, AsyncSnapshot<List<ShoppingItem>> snapshot){
              if(!snapshot.hasData){
                return Container();
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  return ShoppingItemWidget(shoppingItem: snapshot.data[index],);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
