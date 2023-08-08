import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<CounterIncreasedEvent>(_counterIncreasedEvent);

    on<CounterDecreasedEvent>(_counterDecreasedEvent);
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
