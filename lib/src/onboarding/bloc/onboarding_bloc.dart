import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {

  final PageController pageController = PageController();

  OnboardingBloc() : super(OnboardingState(currentIndex: 0)) {

    on<PageChangedEvent>((event, emit) {
      emit(OnboardingState(currentIndex: event.index));
    });

    on<NextPageEvent>((event, emit) {

      if (state.currentIndex < 2) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }

    });

  }

}