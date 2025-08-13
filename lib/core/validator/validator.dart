class Validators {
  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'phoneNumber cannot be empty';
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }

  static String? validateSeatId(String value) {
    if (value.isEmpty) {
      return 'SeatId cannot be empty';
    }
    return null;
  }

  static String? validateNationlId(String value) {
    if (value.isEmpty) {
      return 'National Id cannot be empty';
    }
    return null;
  }

  static String? validateNationality(String value) {
    if (value.isEmpty) {
      return 'Nationality cannot be empty';
    }
    return null;
  }

  static String? validateDrivingLicenseExpiry(String value) {
    if (value.isEmpty) {
      return 'Driving license expiry date cannot be empty';
    }
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value)) {
      return 'Driving license expiry must be in YYYY-MM-DD format';
    }
    try {
      DateTime.parse(value);
    } catch (_) {
      return 'Driving license expiry is not a valid date';
    }
    return null;
  }


  static String? validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'National ID is required';
    }
    return null;
  }
   static String? validateDrivingLicense(String? value) {
    if (value == null || value.isEmpty) {
      return 'Driving License is required';
    }
    return null;
  }
  static String? validatePlateNumber(String value) {
    if (value.isEmpty) {
      return 'Plate number cannot be empty';
    }
    return null;
  }

  static String? validateVehicleModel(String value) {
    if (value.isEmpty) {
      return 'Vehicle model cannot be empty';
    }
    return null;
  }

  static String? validateManufacturingYear(String value) {
    if (value.isEmpty) {
      return 'Manufacturing year cannot be empty';
    }
    int? year = int.tryParse(value);
    if (year == null) {
      return 'Manufacturing year must be a number';
    }
        return null;

  }


}
