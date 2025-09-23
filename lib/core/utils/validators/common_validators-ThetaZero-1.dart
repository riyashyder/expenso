//validators for different uses

class Rvalidators {
  //email validation
  bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  List<String> validEmailExtensions = [
    '.com', '.org', '.net', '.edu', '.gov', '.int', '.mil',
    '.info', '.biz', '.co', '.io', '.me', '.app', '.dev', '.cloud',
    '.shop', '.store', '.online', '.site', '.tech', '.website', '.space',
    '.blog', '.design', '.media', '.agency', '.global', '.solutions', '.today',
    '.world', '.company', '.digital', '.group', '.life', '.network',
    '.services', '.studio', '.systems', '.tools', '.zone', '.ae','.in','.lk','.sg'
  ];

// bool isValiddEmail(String email) {
//   final trimmedEmail = email.trim();

//   final emailRegex = RegExp(
//     r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
//   );

//   if (!emailRegex.hasMatch(trimmedEmail)) {
//     return false;
//   }

//   return validEmailExtensions.any(
//     (ext) => trimmedEmail.toLowerCase().endsWith(ext),
//   );
// }

//password validation
}
