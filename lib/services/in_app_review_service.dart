import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Logic related to asking user for a review
class InAppReviewService {
  static const _endSessionKey = 'end_session_count';

  const InAppReviewService();

  /// Count the amount of "tests" user interacted with
  /// and request review every second test, 3 times max
  Future<void> onTestingSessionEnd() async {
    final prefs = await SharedPreferences.getInstance();

    final count = prefs.getInt(_endSessionKey) ?? 0;

    final newCount = count + 1;
    await prefs.setInt(_endSessionKey, newCount);

    if (newCount % 2 == 0 && newCount <= 12) {
      await InAppReview.instance.requestReview();
    }
  }
}
