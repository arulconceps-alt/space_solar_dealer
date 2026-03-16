abstract class OnboardingEvent {}

class PageChangedEvent extends OnboardingEvent {
  final int index;
  PageChangedEvent(this.index);
}

class NextPageEvent extends OnboardingEvent {}