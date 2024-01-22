import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_filter_params.dart';
import 'package:parental_app/core/app/blocs/base/params/screen_params.dart';
import 'package:parental_app/domain/failures/failure.dart';
part 'base_screen_event.dart';
part 'base_screen_state.dart';

abstract class BaseScreenBloc<T>
    extends Bloc<BaseScreenEvent, BaseScreenState<T>> {
  BaseScreenBloc() : super(BaseScreenState<T>()) {
    on<CallAction>(onCallAction);
    on<RestoreData>(_restoreData);
  }

  FutureOr<void> onCallAction(
    CallAction event,
    Emitter<BaseScreenState<T>> emit,
  ) async {
    emit(state.copyWith(status: ScreenStatusType.loading));

    final res = await repositoryCall(event.params);
    res.fold((l) {
      log('Error: ${l.message}');
      onFailure(emit, l);
    }, (r) {
      log('Success: ${r.toString()}');
      onSuccess(emit, r, event.params);
    });
  }

  FutureOr<void> _restoreData(
    RestoreData event,
    Emitter<BaseScreenState<T>> emit,
  ) async {
    // ignore: prefer_const_constructors
    emit(BaseScreenState());
  }

  void onFailure(Emitter<BaseScreenState<T>> emit, Failure failure) {
    emit(
      state.copyWith(
        message: failure.message,
        status: ScreenStatusType.error,
        errorCode: failure.code,
      ),
    );
  }

  void onSuccess(
    Emitter<BaseScreenState<T>> emit,
    T value,
    ScreenParams params,
  ) {
    emit(state.copyWith(status: ScreenStatusType.loaded, value: value));
  }

  Future<Either<Failure, T>> repositoryCall(ScreenParams params);
}
