part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}
final class ProfileLoading extends ProfileState {}
final class ProfileSuccess extends ProfileState {
  final ProfileModel profile;

  const ProfileSuccess(this.profile);
}
final class ProfileFailure extends ProfileState {
  final String errorMessage;

  const ProfileFailure({required this.errorMessage});
}
