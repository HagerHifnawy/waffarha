import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waffarha/core/theme/text_styles.dart';
import 'package:waffarha/features/home/data/repo/home_repo.dart';
import '../../../core/shared_widgets/loading.dart';
import '../../../core/theme/colors.dart';
import '../data/models/home_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepository) : super(HomeInitialState());
  final HomeRepository _homeRepository;

  /// Get Home
  ///
  List<HomeModel>? homeModel;
  Future getHome() async {
    showLoading();
    emit(GetHomeLoadingState());
    final result = await _homeRepository.getHome();
    result.when(success: (success) {
      homeModel = success;
      filteredModel = List.from(homeModel!);
      hideLoading();
      emit(GetHomeSuccessState());
    }, failure: (error) {
      hideLoading();
      emit(GetHomeFailedState());
    });
  }

  /// Pagination
  int currentPage = 0;
  int itemsPerPage = 10;

  void changePage(bool isNext) {
    if (currentPage > 0 && isNext == false) {
      currentPage--;
    } else if (isNext == true) {
      currentPage++;
    }
    emit(ChangePageState());
  }

  /// Sorting Data
  String? sortBy;
  bool sortAsc = true;
  void sortByAlbumId() {
    sortBy = 'albumId';
    _sortData();
    emit(SortByAlbumIdState());
  }

  void sortByTitle() {
    sortBy = 'title';
    _sortData();
    emit(SortByPhotoTitleState());
  }

  void _sortData() {
    if (filteredModel == null) return;
    filteredModel = List.from(homeModel!);
    filteredModel!.sort((a, b) {
      int result;
      if (sortBy == 'albumId') {
        result = (a.albumId ?? 0).compareTo(b.albumId ?? 0);
      } else if (sortBy == 'title') {
        result = (a.title ?? '')
            .toLowerCase()
            .compareTo((b.title ?? '').toLowerCase());
      } else {
        return 0;
      }
      return sortAsc ? result : -result;
    });
  }

  void showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Sort Options",
                      style: rubikMedium.copyWith(
                        fontSize: 18.sp,
                      )),
                  10.verticalSpace,
                  ListTile(
                    leading: Icon(
                      Icons.filter_alt,
                      color: AppColors.primaryColor,
                      size: 35.r,
                    ),
                    title: Text(
                      "Album ID",
                      style: rubikMedium.copyWith(fontSize: 16.sp),
                    ),
                    onTap: () {
                      sortByAlbumId();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.title,
                      color: AppColors.primaryColor,
                      size: 35.r,
                    ),
                    title: Text(
                      "Photo Title",
                      style: rubikMedium.copyWith(fontSize: 16.sp),
                    ),
                    onTap: () {
                      sortByTitle();
                      Navigator.pop(context);
                    },
                  ),
                  SwitchListTile(
                    title: Text(
                      "Ascending",
                      style: rubikMedium.copyWith(fontSize: 16.sp),
                    ),
                    value: sortAsc,
                    onChanged: (val) {
                      setState(() {
                        sortAsc = val;
                      });
                    },
                  )
                ],
              ),
            );
          });
        });
  }

  /// Filter Data With Album Id
  List<HomeModel>? filteredModel;
  int? selectedAlbumId;
  void filterByAlbumId(int? albumId) {
    selectedAlbumId = albumId;
    if (albumId == null) {
      filteredModel = List.from(homeModel!);
    } else {
      filteredModel =
          homeModel!.where((item) => item.albumId == albumId).toList();
    }
    emit(FilterByAlbumIdState());
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            final albumIds = homeModel!.map((e) => e.albumId!).toSet().toList()
              ..sort();
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              children: [
                ListTile(
                  title: Text(
                    "Show All",
                    style: rubikMedium.copyWith(fontSize: 16.sp),
                  ),
                  onTap: () {
                    filterByAlbumId(null);
                    Navigator.pop(context);
                  },
                ),
                ...albumIds.map((id) => ListTile(
                      title: Text("Album $id"),
                      onTap: () {
                        filterByAlbumId(id);
                        Navigator.pop(context);
                      },
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
