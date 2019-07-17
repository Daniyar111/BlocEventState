import 'package:authentication_bloc/src/data/blocs/shopping_bloc/shopping_bloc.dart';
import 'package:authentication_bloc/src/data/providers/bloc_provider.dart';
import 'package:flutter/material.dart';

class ShoppingBasketPrice extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);

    return StreamBuilder(
      stream: bloc.shoppingBasketPrice,
      initialData: 0.0,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot){
        return Text('Total: ${snapshot.data} KGS', style: TextStyle(fontSize: 12.0),);
      },
    );
  }
}
