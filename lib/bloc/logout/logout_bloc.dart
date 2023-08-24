import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/memory_service.dart';

class LogoutBloc extends Cubit<bool> {
  final MemoryService _memory;

  LogoutBloc(this._memory) : super(false);

  void logout() async {
    bool result = await _memory.removeToken();
    emit(result);
  }
}
