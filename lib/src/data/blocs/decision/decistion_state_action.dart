import 'package:authentication_bloc/src/data/providers/bloc_event_state.dart';
import 'package:flutter/material.dart';

class DecisionStateAction extends BlocState{

  final Widget newPage;
  final DecisionStateActionType actionType;

  DecisionStateAction({
    this.actionType = DecisionStateActionType.nothing,
    this.newPage
  });

  factory DecisionStateAction.routeToPage(Widget page){
    return DecisionStateAction(
      newPage: page,
      actionType: DecisionStateActionType.routeToPage
    );
  }

  factory DecisionStateAction.nothing(){
    return DecisionStateAction();
  }

  @override
  bool operator ==(other) {
    return identical(this, other) || other is DecisionStateAction && actionType == other.actionType || newPage == other.newPage;
  }

  @override
  int get hashCode => hashValues(actionType, newPage);

}


enum DecisionStateActionType{
  nothing,
  routeToPage
}