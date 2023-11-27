import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { Hard, Medium, Easy }

List<String> fillSourceArray() {
  return [
    'assets/languages/android.png',
    'assets/languages/android.png',
    'assets/languages/logo-c-1.png',
    'assets/languages/logo-c-1.png',
    'assets/languages/php.png',
    'assets/languages/php.png',
    'assets/languages/js.png',
    'assets/languages/js.png',
    'assets/languages/Java_programming.png',
    'assets/languages/Java_programming.png',
    'assets/languages/dart.png',
    'assets/languages/dart.png',
    'assets/languages/python.png',
    'assets/languages/python.png',
    'assets/languages/Android_Studio.png',
    'assets/languages/Android_Studio.png',
    'assets/languages/flutter-logo.png',
    'assets/languages/flutter-logo.png',
  ];
}

List<String> getSourceArray(Level level) {
  List<String> levelAndKindList = [];
  List<dynamic> sourceArray = fillSourceArray(); // Assuming fillSourceArray returns List<dynamic>
  if (level == Level.Hard) {
    levelAndKindList.addAll(sourceArray.cast<String>());
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      levelAndKindList.add(sourceArray[i].toString());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      levelAndKindList.add(sourceArray[i].toString());
    }
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(Level level) {
  List<bool> initialItemState =  [];
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> card =
  [];
  if (level == Level.Hard) {            //addcards
    for (int i = 0; i < 18; i++) {
      card.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      card.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      card.add(GlobalKey<FlipCardState>());
    }
  }
  return card;
}
