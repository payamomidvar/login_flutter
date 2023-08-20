import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/memory_service.dart';


class LoginMemoryBloc extends Cubit<bool> {
  final MemoryService _memory;

  LoginMemoryBloc(this._memory) : super(false);

  Future<void> saveToken(String token) async {
    bool result = await _memory.saveToken(token);
    emit(result);
  }
}
