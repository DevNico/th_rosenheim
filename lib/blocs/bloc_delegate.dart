import 'package:flutter_bloc/flutter_bloc.dart';

import '../logger.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    logger.v('${bloc.runtimeType}: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.d('--- ${bloc.runtimeType} Transition ---\n'
        'currentState: ${transition.currentState}\n'
        'event: ${transition.event}\n'
        'nextState: ${transition.nextState}');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    logger.e('Error in ${bloc.runtimeType}', error, stacktrace);
  }
}
