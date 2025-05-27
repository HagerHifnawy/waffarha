part of 'home_cubit.dart';
@immutable
abstract class HomeState {
  const HomeState();
  List<Object?> get props => [];
}
class HomeInitialState extends HomeState {}

/// Get Home
class GetHomeLoadingState extends HomeState {}
class GetHomeSuccessState extends HomeState {}
class GetHomeFailedState extends HomeState {}

/// Pagination
class ChangePageState extends HomeState {}

/// Sorting Data
class SortByAlbumIdState extends HomeState {}
class SortByPhotoTitleState extends HomeState {}

/// Filter Data With Album Id
class FilterByAlbumIdState extends HomeState {}

