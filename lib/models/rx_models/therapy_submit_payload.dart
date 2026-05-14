class TherapySubmitPayload {
  final int manualSpeechId;
  final int? therapySubcategoryId;
  final String? note;

  const TherapySubmitPayload({
    required this.manualSpeechId,
    this.therapySubcategoryId,
    this.note,
  });
}