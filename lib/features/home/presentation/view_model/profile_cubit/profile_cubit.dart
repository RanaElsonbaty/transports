import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:transports/features/home/data/models/profile_view.dart';
import 'package:transports/features/home/data/repos/profile/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  ProfileRepo profileRepo;
  Future<void>getProfileInfo()async{
    emit(ProfileLoading());
final result= await profileRepo.getProfiles();
result.fold((fail)=>emit(ProfileFailure(errorMessage: fail.errorMessage)), (success)=>emit(ProfileSuccess(success)));
  }
}
