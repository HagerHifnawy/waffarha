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
  List<HomeModel>? homeModel;
  Future getHome() async {
    showLoading(); //Start Loading Widget
    emit(GetHomeLoadingState());
    // Using HomeRepository to get Home Data From Api
    final result = await _homeRepository.getHome();
    result.when(success: (success) {
      // Set Data in List of Home model
      homeModel = success;
      filteredModel = List.from(homeModel!);
      hideLoading(); //End Loading Widget
      emit(GetHomeSuccessState());
    }, failure: (error) {
      hideLoading(); //End Loading Widget
      emit(GetHomeFailedState());
    });
  }

  /// Pagination
  int currentPage = 0;
  int itemsPerPage = 10;
  void changePage(bool isNext) {
    // If Current Page is bigger than 0 can go Back
    if (currentPage > 0 && isNext == false) {
      currentPage--;
    }
    // if the button clicked is next go next Page
    else if (isNext == true) {
      currentPage++;
    }
    emit(ChangePageState());
  }

  /// Sorting Data
  String? sortBy;
  bool sortAsc = true;
  void sortByAlbumId() {
    // Set value for variable SortBy to albumId
    sortBy = 'albumId';
    _sortData();
    emit(SortByAlbumIdState());
  }

  void sortByTitle() {
    // Set value for variable SortBy to title
    sortBy = 'title';
    _sortData();
    emit(SortByPhotoTitleState());
  }

  void _sortData() {
    // IF filteredModel Data is null don't do any thing
    if (filteredModel == null) return;
    // Before Start Sorting Set filteredModel = homeModel Data
    filteredModel = List.from(homeModel!);
    currentPage=0;
    // Use fun Sort to compare and sort data in filteredModel list
    filteredModel!.sort((a, b) {
      int result;
      // If sortBy == albumId make filteredModel List Sorted with album id
      if (sortBy == 'albumId') {
        result = (a.albumId ?? 0).compareTo(b.albumId ?? 0);
      }
      // If sortBy == title make filteredModel List Sorted with photoTitle
      else if (sortBy == 'title') {
        result = (a.title ?? '')
            .toLowerCase()
            .compareTo((b.title ?? '').toLowerCase());
      } else {
        return 0;
      }
      // If Sort Ascending is true return result else return -result (reversed list)
      return sortAsc ? result : -result;
    });
  }

  /// Bottom Sheet To Select Sort Type(Album id OR Photo Title)
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
                      // set Value for Sorting Ascending
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
  void filterByAlbumId(int? albumId) {
    currentPage=0;
    // If album id == null its mean show all ids
    if (albumId == null) {
      filteredModel = List.from(homeModel!);
    } else {
      // Make filteredModel List == all items in homeModel List Where album id == any item.albumId
      filteredModel =
          homeModel!.where((item) => item.albumId == albumId).toList();
    }
    emit(FilterByAlbumIdState());
  }

  /// Bottom Sheet to Show All Album Id in homeModel List and select Album id to filter with it
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
