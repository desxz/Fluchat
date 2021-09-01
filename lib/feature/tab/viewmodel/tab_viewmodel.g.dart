// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TabViewModel on _TabViewModelBase, Store {
  final _$initPageAtom = Atom(name: '_TabViewModelBase.initPage');

  @override
  int? get initPage {
    _$initPageAtom.reportRead();
    return super.initPage;
  }

  @override
  set initPage(int? value) {
    _$initPageAtom.reportWrite(value, super.initPage, () {
      super.initPage = value;
    });
  }

  final _$pageListAtom = Atom(name: '_TabViewModelBase.pageList');

  @override
  List<Widget> get pageList {
    _$pageListAtom.reportRead();
    return super.pageList;
  }

  @override
  set pageList(List<Widget> value) {
    _$pageListAtom.reportWrite(value, super.pageList, () {
      super.pageList = value;
    });
  }

  @override
  String toString() {
    return '''
initPage: ${initPage},
pageList: ${pageList}
    ''';
  }
}
