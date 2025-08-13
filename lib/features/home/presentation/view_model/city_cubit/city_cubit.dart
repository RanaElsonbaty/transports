import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/home/data/models/city_model.dart';
import 'package:transports/features/home/data/repos/city/city_repo.dart';
part 'city_state.dart';
class CityCubit extends Cubit<CityState> {
  CityCubit(this.cityRepo) : super(CityInitial());
  CityRepo cityRepo;
  Future<void>fetchCities()async{
    emit(CityLoading());
 final result=  await cityRepo.getCities();
 result.fold((fail)=>emit(CityFailure(errorMessage: fail.errorMessage)), (data)=>emit(CitySuccess(data)));
  }
}
