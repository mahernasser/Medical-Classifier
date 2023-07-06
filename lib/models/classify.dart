class ClassifiedImage {
  dynamic id;
  dynamic image;
  dynamic patientUsername;
  dynamic patientGender;
  dynamic patientAge;
  dynamic patientPhone;
  dynamic patientEmail;
  List<Classification> classification;

  dynamic approved;
  dynamic date;
  dynamic diagnose;

  ClassifiedImage({
    required this.id,
    required this.image,
    this.patientUsername,
    this.patientGender,
    this.patientAge,
    this.patientPhone,
    this.patientEmail,
    required this.classification,
    required this.approved,
    required this.date,
    this.diagnose,
  });

  factory ClassifiedImage.fromJson(Map<dynamic, dynamic> json) {
    return ClassifiedImage(
      id: json['id'],
      image: json['image'],
      patientUsername: json['patientUsername'],
      patientGender: json['patientGender'],
      patientAge: json['patientAge'],
      patientPhone: json['patientPhone'],
      patientEmail: json['patientEmail'],
      classification: json['classification'] != null
          ? List<Classification>.from(
              json['classification'].map((x) => Classification.fromJson(x)))
          : [],
      approved: json['approved'],
      date: json['date'],
      diagnose: json['diagnose'],
    );
  }
}

class Classification {
  dynamic name;
  dynamic value;

  Classification({this.name, this.value});

  factory Classification.fromJson(Map<dynamic, dynamic> json) {
    return Classification(
      name: json['classification'],
      value: json['confidence'],
    );
  }
}
