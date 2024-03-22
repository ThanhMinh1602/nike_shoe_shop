part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.homeInitialEvent() = HomeInitialEvent;
  const factory HomeEvent.homeLoadMorePopularEvent() = HomeLoadMorePopularEvent;
  const factory HomeEvent.homeLoadMoreNewArrivalEvent() =
      HomeLoadMoreNewArrivalEvent;
  const factory HomeEvent.onTapToDetailProductEvent(ProductModel productModel) =
      OnTapToDetailProductEvent;
  const factory HomeEvent.onTapCategoryEvent(int cateId) = OnTapCategoryEvent;
}
