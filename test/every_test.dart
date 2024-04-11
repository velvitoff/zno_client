//import 'package:client/locator.dart';
import 'exam_files/questions_test.dart' as questions_test;
import 'exam_files/answers_test.dart' as answers_test;
import 'exam_files/scoring_test.dart' as scoring_test;
import 'models/testing_route_model_test.dart' as testing_route_model_test;
import 'exam_files/loading_answers_test.dart' as loading_answers_test;

void main() {
  //getItSetup();
  questions_test.main();
  answers_test.main();
  scoring_test.main();
  testing_route_model_test.main();
  loading_answers_test.main();
}
