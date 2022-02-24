abstract class NewsStates {}

class InitialState extends NewsStates {}

class BottomNavState extends NewsStates {}

class GetBusinessLoadingState extends NewsStates {}

class GetBusinessSuccessfulyState extends NewsStates {}

class GetBusinessErrorState extends NewsStates {
  late final String error;

  GetBusinessErrorState(this.error);
}
class GetSportsLoadingState extends NewsStates {}

class GetSportsSuccessfulyState extends NewsStates {}

class GetSportsErrorState extends NewsStates {
  late final String error;

  GetSportsErrorState(this.error);
}
class GetScienceLoadingState extends NewsStates {}

class GetScienceSuccessfulyState extends NewsStates {}

class GetScienceErrorState extends NewsStates {
  late final String error;

  GetScienceErrorState(this.error);
}
class GetSearchLoadingState extends NewsStates {}

class GetSearchSuccessfulyState extends NewsStates {}

class GetSearchErrorState extends NewsStates {
  late final String error;

  GetSearchErrorState(this.error);
}

class AppChangeModeState extends NewsStates{}