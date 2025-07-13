
import 'package:flutter_application_2/screen/ExpendTypeManagement/KB/bloc/kb_event.dart';
import 'package:flutter_application_2/screen/ExpendTypeManagement/KB/bloc/kb_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KbBloc extends Bloc<KBEvent, KBState> {
  KbBloc() : super(const KBState()) {
    on<KBEvent>((event, emit) {
    });
  }
}
