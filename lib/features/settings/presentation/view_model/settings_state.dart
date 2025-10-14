part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final SettingsModel settings;
  SettingsSuccess(this.settings);
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);
}
