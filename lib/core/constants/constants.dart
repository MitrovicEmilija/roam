import 'package:roam/features/home/screens/feed_screen.dart';
import 'package:roam/features/community/screens/community_screen.dart';
import 'package:roam/features/trips/screens/trips_screen.dart';

class Constants {
  static const logoPath = 'assets/images/logo.png';
  static const googlePath = 'assets/images/google.png';
  static const onboardBg = 'assets/images/onboard.jpg';

  static const profileDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';

  static const tabWidgets = [
    FeedScreen(),
    CommunityScreen(uid: ''),
    TripsScreen(uid: '')
  ];
}
