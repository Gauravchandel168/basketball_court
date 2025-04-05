import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitial());
  void joinCall() => emit(CallJoined());
  void leaveCall() => emit(CallLeft());
}
