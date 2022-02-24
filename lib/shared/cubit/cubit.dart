import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/scinece_screen.dart';
import 'package:news_app/modules/sports/sport_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_baseball), label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Scinece'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScinenceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(BottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> searchResualt = [];

  void getBusiness() {
    emit(GetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'business',
        'apiKey': 'e568c333ac674e4891c9e79d34e934a8',
      }).then((value) {
        //print(value.data.toString());
        business = value.data['articles'];
        emit(GetBusinessSuccessfulyState());
      }).catchError((e) {
        print(e.toString());
        emit(GetBusinessErrorState(e.toString()));
      });
    } else {
      GetBusinessSuccessfulyState();
    }
  }

  void getSports() {
    emit(GetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': 'e568c333ac674e4891c9e79d34e934a8',
      }).then((value) {
        //print(value.data.toString());
        sports = value.data['articles'];
        emit(GetSportsSuccessfulyState());
      }).catchError((e) {
        print(e.toString());
        emit(GetSportsErrorState(e.toString()));
      });
    } else {
      emit(GetSportsSuccessfulyState());
    }
  }

  void getScience() {
    emit(GetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': 'e568c333ac674e4891c9e79d34e934a8',
      }).then((value) {
        //print(value.data.toString());
        science = value.data['articles'];
        emit(GetScienceSuccessfulyState());
      }).catchError((e) {
        print(e.toString());
        emit(GetScienceErrorState(e.toString()));
      });
    } else {
      GetScienceSuccessfulyState();
    }
  }

  void getResualt(String value) {
    emit(GetSearchLoadingState());
    searchResualt = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'e568c333ac674e4891c9e79d34e934a8',
    }).then((value)
    {
      searchResualt = value.data['articles'];
      emit(GetSearchSuccessfulyState());
    }).catchError((e) {
      print(e.toString());
      emit(GetSearchErrorState(e.toString()));
    });

  }

  bool isDark = true;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
