part of 'extract_image_cubit.dart';

@immutable
abstract class ExtractImageState {}

class ExtractImageInitial extends ExtractImageState {}

class ExtractImageLoading extends ExtractImageState {}

class ExtractImageSuccess extends ExtractImageState {
  final ExtractImageModel model;
  ExtractImageSuccess(this.model);
}

class ExtractImageFailure extends ExtractImageState {
  final String message;
  ExtractImageFailure(this.message);
}
