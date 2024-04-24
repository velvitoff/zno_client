part of 'question.dart';

enum ScoringEnum { wrong, correct, partial }

class ScoringResult {
  final int score;
  final int total;
  final ScoringEnum scoringEnum;

  const ScoringResult({
    required this.score,
    required this.total,
    required this.scoringEnum,
  });

  factory ScoringResult.wrong({required int total}) {
    return ScoringResult(
        score: 0, total: total, scoringEnum: ScoringEnum.wrong);
  }

  factory ScoringResult.correct({required int score, required int total}) {
    return ScoringResult(
        score: score, total: total, scoringEnum: ScoringEnum.correct);
  }

  factory ScoringResult.partial({required int score, required int total}) {
    return ScoringResult(
        score: score, total: total, scoringEnum: ScoringEnum.partial);
  }

  bool get isCorrect => scoringEnum == ScoringEnum.correct;
  bool get isWrong => scoringEnum == ScoringEnum.wrong;
  bool get isPartial => scoringEnum == ScoringEnum.partial;
}
