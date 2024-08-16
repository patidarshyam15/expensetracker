class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Track Your expense and get the result",
    image: "assets/images/onboarding1.png",
    desc: "Remember to keep track of your professional accomplishments.",
  ),
  OnboardingContents(
    title: "Track Your expense and get the result",
    image: "assets/images/onboarding2.png",
    desc: "Remember to keep track of your professional accomplishments.",
  ),
  OnboardingContents(
    title: "Track Your expense and get the result",
    image: "assets/images/onboarding3.png",
    desc: "Remember to keep track of your professional accomplishments.",
  ),
];
