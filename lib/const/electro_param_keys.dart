/// Canonical parameter keys for electrotherapy.
///
/// Use ONLY these constants when:
/// - storing selected parameters in [QuickTechElectrotherapyController]
/// - reading them in [QuickTechmainPrescriptionControllr] (API payload)
/// - reading them in [QuickTechPdfController] (PDF rendering)
///
/// Never hard-code the string literals; reference the constant instead.
class ElectroParamKeys {
  // ── Area ────────────────────────────────────────────────────────────────
  /// Raw param name used as the UI-widget key (FilterChip / Dropdown)
  static const kAreaOptions = 'Area Options';

  /// Human-readable area names stored alongside IDs for UI display
  static const kAreaNames = 'Area Names';

  /// Numeric area IDs sent to the backend
  static const kAreaIds = 'Area IDs';

  // ── Electrical ──────────────────────────────────────────────────────────
  static const kFrequency = 'Frequency';
  static const kPulseDuration = 'Pulse Duration/Ratio'; // covers both pulse-ratio & pulse-duration
  static const kPulseWidth = 'Pulse Width';
  static const kPulseRate = 'Pulse Rate';
  static const kAverageWatt = 'Average Watt';
  static const kIntensity = 'Intensity';

  // ── Traction ────────────────────────────────────────────────────────────
  static const kTractionWeight = 'Traction Weight';
  static const kHoldTime = 'Hold Time';
  static const kRestTime = 'Rest Time';

  // ── IRR ─────────────────────────────────────────────────────────────────
  static const kTypeOfIrr = 'Type of IRR';
  static const kDistance = 'Distance';

  // ── Session (stored by UI text fields, read by RX controller + PDF) ─────
  static const kTherapyTime = 'therapy_time';
  static const kTotalTreatmentTime = 'total_treatment_time';
  static const kVisitingFrequency = 'visiting_frequency';
}
