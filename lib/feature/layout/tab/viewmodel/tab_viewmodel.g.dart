// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TabViewModel on _TabViewModelBase, Store {
  final _$selectedNavBarItemAtom =
      Atom(name: '_TabViewModelBase.selectedNavBarItem');

  @override
  int get selectedNavBarItem {
    _$selectedNavBarItemAtom.reportRead();
    return super.selectedNavBarItem;
  }

  @override
  set selectedNavBarItem(int value) {
    _$selectedNavBarItemAtom.reportWrite(value, super.selectedNavBarItem, () {
      super.selectedNavBarItem = value;
    });
  }

  @override
  String toString() {
    return '''
selectedNavBarItem: ${selectedNavBarItem}
    ''';
  }
}
