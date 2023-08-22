import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/memory_service.dart';

part 'token_event.dart';

part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final MemoryService _memoryService;

  TokenBloc(this._memoryService) : super(const TokenState()) {
    on<TokenEvent>(_mapGetTokenEventToState);
  }

  void _mapGetTokenEventToState(
      TokenEvent event, Emitter<TokenState> emit) async {
    String? token = _memoryService.getToken;
    emit(TokenState(token: token));
  }
}
