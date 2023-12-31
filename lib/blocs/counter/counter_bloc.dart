import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    // sequential() - Bloc Event들 모두를 통합하여 Event 가 순차적으로 실행됨.
    on<CounterEvent>(
      (event, emit) async {
        if (event is CounterIncreasedEvent) {
          await _counterIncreasedEvent(event, emit);
        } else if (event is CounterDecreasedEvent) {
          await _counterDecreasedEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _counterIncreasedEvent(event, emit) async {
    await Future.delayed(const Duration(seconds: 4));
    emit(state.copyWith(counter: state.counter + 1));
  }

  Future<void> _counterDecreasedEvent(event, emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(counter: state.counter - 1));
  }
}
