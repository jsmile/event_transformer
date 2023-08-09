import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    // default 인 parallel 로 event 가 동작함.
    on<CounterIncreasedEvent>(_counterIncreasedEvent);

    on<CounterDecreasedEvent>(
      _counterDecreasedEvent,
      // droppable() - 이전 event 가 끝나기 전에 다음 event 가 발생하면 다음 event 를 drop 함.
      transformer: droppable(),
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
