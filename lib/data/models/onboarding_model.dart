import 'package:handy_home_app/presentation/resources/assets_manager.dart';

class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;
  OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

List<OnboardingModel> onboardingData = [
  OnboardingModel(
    imagePath: ImagePath.onboarding1,
    title: 'احصل على مساعدة في خدمات المنزل',
    description: 'اعثر واحجز محترفين مؤهلين لمجموعة واسعة من خدمات المنزل!',
  ),
  OnboardingModel(
    imagePath: ImagePath.onboarding2,
    title: 'وفر الوقت والمال',
    description: 'احجز خدمة ببضع نقرات فقط!',
  ),
  OnboardingModel(
    imagePath: ImagePath.onboarding3,
    title: 'احصل على راحة البال',
    description: 'استمتع بخدمة عالية الجودة من محترف مؤهل!',
  ),
];
