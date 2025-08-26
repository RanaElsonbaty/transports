class ExtractImageModel {
  final bool? success;
  final String? message;
  final Data? data;
  final dynamic errors;

  ExtractImageModel({
    this.success,
    this.message,
    this.data,
    this.errors,
  });

  factory ExtractImageModel.fromJson(Map<String, dynamic> json) {
    return ExtractImageModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      errors: json['errors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
      'errors': errors,
    };
  }
}

class Data {
  final ExtractedData? extractedData;

  Data({this.extractedData});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      extractedData: json['extracted_data'] != null
          ? ExtractedData.fromJson(json['extracted_data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'extracted_data': extractedData?.toJson(),
    };
  }
}

class ExtractedData {
  final String? fullName;
  final String? fullNameAr;
  final String? firstName;
  final String? firstNameAr;
  final String? lastName;
  final String? lastNameAr;
  final String? middleName;
  final dynamic age;
  final String? dateOfBirth;
  final dynamic gender;
  final String? nationality;
  final String? nationalityAr;
  final String? country;
  final dynamic address;
  final dynamic phoneNumber;
  final dynamic email;
  final String? nationalId;
  final dynamic passportNumber;
  final dynamic idNumber;
  final dynamic documentNumber;
  final dynamic dateOfIssue;
  final String? dateOfExpiry;
  final String? issuingAuthority;
  final String? issuingAuthorityAr;
  final dynamic drivingLicenseNumber;
  final dynamic drivingLicenseExpiry;
  final dynamic licenseClass;
  final dynamic licenseType;
  final dynamic plateNumber;
  final dynamic plateWord;
  final dynamic vehicleModel;
  final dynamic vehicleMake;
  final dynamic vehicleType;
  final dynamic manufacturingYear;
  final dynamic engineNumber;
  final dynamic chassisNumber;
  final dynamic capacity;
  final dynamic color;
  final dynamic fuelType;
  final dynamic registrationNumber;
  final dynamic registrationWord;
  final dynamic registrationExpiry;
  final String? ownerName;
  final dynamic ownerAddress;
  final dynamic insuranceNumber;
  final dynamic insuranceExpiry;
  final dynamic insuranceCompany;
  final dynamic policyNumber;
  final dynamic bloodType;
  final String? occupation;
  final String? occupationAr;
  final String? employer;
  final dynamic emergencyContact;
  final dynamic emergencyPhone;
  final dynamic notes;
  final String? documentType;
  final String? placeOfBirth;
  final String? placeOfBirthAr;
  final String? religion;
  final String? religionAr;
  final String? placeOfIssue;
  final String? placeOfWork;
  final String? employerId;

  ExtractedData({
    this.fullName,
    this.fullNameAr,
    this.firstName,
    this.firstNameAr,
    this.lastName,
    this.lastNameAr,
    this.middleName,
    this.age,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.nationalityAr,
    this.country,
    this.address,
    this.phoneNumber,
    this.email,
    this.nationalId,
    this.passportNumber,
    this.idNumber,
    this.documentNumber,
    this.dateOfIssue,
    this.dateOfExpiry,
    this.issuingAuthority,
    this.issuingAuthorityAr,
    this.drivingLicenseNumber,
    this.drivingLicenseExpiry,
    this.licenseClass,
    this.licenseType,
    this.plateNumber,
    this.plateWord,
    this.vehicleModel,
    this.vehicleMake,
    this.vehicleType,
    this.manufacturingYear,
    this.engineNumber,
    this.chassisNumber,
    this.capacity,
    this.color,
    this.fuelType,
    this.registrationNumber,
    this.registrationWord,
    this.registrationExpiry,
    this.ownerName,
    this.ownerAddress,
    this.insuranceNumber,
    this.insuranceExpiry,
    this.insuranceCompany,
    this.policyNumber,
    this.bloodType,
    this.occupation,
    this.occupationAr,
    this.employer,
    this.emergencyContact,
    this.emergencyPhone,
    this.notes,
    this.documentType,
    this.placeOfBirth,
    this.placeOfBirthAr,
    this.religion,
    this.religionAr,
    this.placeOfIssue,
    this.placeOfWork,
    this.employerId,
  });

  factory ExtractedData.fromJson(Map<String, dynamic> json) {
    return ExtractedData(
      fullName: json['full_name'] as String?,
      fullNameAr: json['full_name_ar'] as String?,
      firstName: json['first_name'] as String?,
      firstNameAr: json['first_name_ar'] as String?,
      lastName: json['last_name'] as String?,
      lastNameAr: json['last_name_ar'] as String?,
      middleName: json['middle_name'] as String?,
      age: json['age'],
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'],
      nationality: json['nationality'] as String?,
      nationalityAr: json['nationality_ar'] as String?,
      country: json['country'] as String?,
      address: json['address'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      nationalId: json['national_id'] as String?,
      passportNumber: json['passport_number'],
      idNumber: json['id_number'],
      documentNumber: json['document_number'],
      dateOfIssue: json['date_of_issue'],
      dateOfExpiry: json['date_of_expiry'] as String?,
      issuingAuthority: json['issuing_authority'] as String?,
      issuingAuthorityAr: json['issuing_authority_ar'] as String?,
      drivingLicenseNumber: json['driving_license_number'],
      drivingLicenseExpiry: json['driving_license_expiry'],
      licenseClass: json['license_class'],
      licenseType: json['license_type'],
      plateNumber: json['plate_number'],
      plateWord: json['plate_word'],
      vehicleModel: json['vehicle_model'],
      vehicleMake: json['vehicle_make'],
      vehicleType: json['vehicle_type'],
      manufacturingYear: json['manufacturing_year'],
      engineNumber: json['engine_number'],
      chassisNumber: json['chassis_number'],
      capacity: json['capacity'],
      color: json['color'],
      fuelType: json['fuel_type'],
      registrationNumber: json['registration_number'],
      registrationWord: json['registration_word'],
      registrationExpiry: json['registration_expiry'],
      ownerName: json['owner_name']as String?,
      ownerAddress: json['owner_address'],
      insuranceNumber: json['insurance_number'],
      insuranceExpiry: json['insurance_expiry'],
      insuranceCompany: json['insurance_company'],
      policyNumber: json['policy_number'],
      bloodType: json['blood_type'],
      occupation: json['occupation'] as String?,
      occupationAr: json['occupation_ar'] as String?,
      employer: json['employer'] as String?,
      emergencyContact: json['emergency_contact'],
      emergencyPhone: json['emergency_phone'],
      notes: json['notes'],
      documentType: json['document_type'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      placeOfBirthAr: json['place_of_birth_ar'] as String?,
      religion: json['religion'] as String?,
      religionAr: json['religion_ar'] as String?,
      placeOfIssue: json['place_of_issue'] as String?,
      placeOfWork: json['place_of_work'] as String?,
      employerId: json['employer_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'full_name_ar': fullNameAr,
      'first_name': firstName,
      'first_name_ar': firstNameAr,
      'last_name': lastName,
      'last_name_ar': lastNameAr,
      'middle_name': middleName,
      'age': age,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'nationality': nationality,
      'nationality_ar': nationalityAr,
      'country': country,
      'address': address,
      'phone_number': phoneNumber,
      'email': email,
      'national_id': nationalId,
      'passport_number': passportNumber,
      'id_number': idNumber,
      'document_number': documentNumber,
      'date_of_issue': dateOfIssue,
      'date_of_expiry': dateOfExpiry,
      'issuing_authority': issuingAuthority,
      'issuing_authority_ar': issuingAuthorityAr,
      'driving_license_number': drivingLicenseNumber,
      'driving_license_expiry': drivingLicenseExpiry,
      'license_class': licenseClass,
      'license_type': licenseType,
      'plate_number': plateNumber,
      'plate_word': plateWord,
      'vehicle_model': vehicleModel,
      'vehicle_make': vehicleMake,
      'vehicle_type': vehicleType,
      'manufacturing_year': manufacturingYear,
      'engine_number': engineNumber,
      'chassis_number': chassisNumber,
      'capacity': capacity,
      'color': color,
      'fuel_type': fuelType,
      'registration_number': registrationNumber,
      'registration_word': registrationWord,
      'registration_expiry': registrationExpiry,
      'owner_name': ownerName,
      'owner_address': ownerAddress,
      'insurance_number': insuranceNumber,
      'insurance_expiry': insuranceExpiry,
      'insurance_company': insuranceCompany,
      'policy_number': policyNumber,
      'blood_type': bloodType,
      'occupation': occupation,
      'occupation_ar': occupationAr,
      'employer': employer,
      'emergency_contact': emergencyContact,
      'emergency_phone': emergencyPhone,
      'notes': notes,
      'document_type': documentType,
      'place_of_birth': placeOfBirth,
      'place_of_birth_ar': placeOfBirthAr,
      'religion': religion,
      'religion_ar': religionAr,
      'place_of_issue': placeOfIssue,
      'place_of_work': placeOfWork,
      'employer_id': employerId,
    };
  }
}
