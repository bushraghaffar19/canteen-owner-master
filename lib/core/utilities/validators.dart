class TextFieldValidations {
  static final RegExp _emailPattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp _phoneNumberpattern =
      RegExp(r'(^(?:[+0]9)?[0-9]{11,12}$)');
  static final RegExp namePattern = RegExp(r"^[a-zA-Z ]*$");

  // ===========================================================================
  // Name Validation
  // ===========================================================================
  static String? nameValidation(String? name) {
    if (name == null || name.isEmpty) {
      return 'This field cannot be empty';
    } else if (name.length < 3) {
      return 'name field contains at least 3 characters';
    }
    else if (!namePattern.hasMatch(name)) {
      return 'Name is invalid';
    }
    return null;
  }

  static String? priceValidation(String? price) {
    if (price == null || price.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }


  static String? descriptionValidation(String? description) {
    if (description == null || description.isEmpty) {
      return 'This field cannot be empty';
    } else if (description.length < 20) {
      return 'name field contains at least 20 characters';
    }
    return null;
  }
  // ===========================================================================
  // Email Validation
  // ===========================================================================
  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email field cannot be empty';
    } else if (!_emailPattern.hasMatch(email)) {
      return 'Email is invalid';
    }
    return null;
  }

  // ===========================================================================
  // Phone number validation
  // ===========================================================================
  static String? phoneNumberValidation(String? phoneNo) {
    if (phoneNo == null || phoneNo.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (!_phoneNumberpattern.hasMatch(phoneNo)) {
      return 'Phone number invalid';
    }
    return null;
  }

  // ===========================================================================
  // Password Validation
  // ===========================================================================
  static String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password field cannot be empty';
    } else if (password.length < 6) {
      return 'Password should be at least of 6 characters';
    }
    return null;
  }

  // ===========================================================================
  // Confirm Password Validation
  // ===========================================================================
  static String? confirmPasswordValidation(
      String? confirmPassword, {required String originalPassword}) {
    if (confirmPassword != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
