  import 'package:flutter/material.dart';
  import '../controller/settings_controller.dart';
  import '../model/user_profile.dart';

  class ProfileScreen extends StatefulWidget {
    final UserProfile? user;

    const ProfileScreen({super.key, required this.user});

    @override
    State<ProfileScreen> createState() => _ProfileScreenState();
  }

  class _ProfileScreenState extends State<ProfileScreen> {
    late TextEditingController firstNameCtrl;
    late TextEditingController lastNameCtrl;
    late TextEditingController emailCtrl;
    late TextEditingController timeZoneCtrl;
    late TextEditingController languageCtrl;
    late TextEditingController currencyCtrl;
    final SettingsController settingsController = SettingsController();
    int selectedAvatar = 1;


    @override
    void initState() {
      super.initState();

      if (widget.user == null) {
        // Initialize empty controllers to avoid LateError
        firstNameCtrl = TextEditingController();
        lastNameCtrl = TextEditingController();
        emailCtrl = TextEditingController();
        timeZoneCtrl = TextEditingController();
        languageCtrl = TextEditingController();
        currencyCtrl = TextEditingController();
        return;
      }

      final u = widget.user!;
      firstNameCtrl = TextEditingController(text: u.firstName);
      lastNameCtrl = TextEditingController(text: u.lastName);
      emailCtrl = TextEditingController(text: u.email);
      timeZoneCtrl = TextEditingController(text: u.timeZone);
      languageCtrl = TextEditingController(text: u.preferredLanguage);
      currencyCtrl = TextEditingController(text: "${u.currencyCode} (${u.currencySymbol})");
      selectedAvatar = u.avatar;
    }

    Future<void> showAvatarPicker(BuildContext context) async {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose Avatar"),
            content: SizedBox(
              height: 260,
              width: double.maxFinite,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  final avatarNo = index + 1;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedAvatar = avatarNo);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedAvatar == avatarNo
                              ? Colors.blue
                              : Colors.transparent,
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                        AssetImage("assets/avatars/a$avatarNo.png"),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }


    // @override
    // void initState() {
    //   super.initState();
    //
    //   final u = widget.user!;
    //   firstNameCtrl = TextEditingController(text: u.firstName);
    //   lastNameCtrl = TextEditingController(text: u.lastName);
    //   emailCtrl = TextEditingController(text: u.email);
    //   timeZoneCtrl = TextEditingController(text: u.timeZone);
    //
    //
    //   // languageCtrl = TextEditingController(text: u.preferredLanguage);
    //   currencyCtrl = TextEditingController(text: "${u.currencyCode} (${u.currencySymbol})");
    // }

    Future<void> showLanguagePicker(BuildContext context) async {
      final List<Map<String, String>> languages = [
        {"label": "English", "code": "en"},
        {"label": "Arabic", "code": "ar"},
        {"label": "Japanese", "code": "ja"}, // FIXED
      ];


      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Select Language"),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: languages.map((lang) {
                return ListTile(
                  title: Text(lang["label"]!),
                  onTap: () {
                    languageCtrl.text = lang["code"]!;
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    }


    Future<void> showCurrencyPicker(
        BuildContext context,
        TextEditingController controller,
        ) async {
      List<CurrencyModel> currencies = [];
      List<CurrencyModel> filtered = [];

      String? selectedCode = controller.text.isNotEmpty ? controller.text : null;

      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              // Load API only once
              if (currencies.isEmpty) {
                fetchCurrencies().then((value) {
                  currencies = value;
                  filtered = value;
                  setState(() {});
                });
              }

              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: const Text("Select Currency"),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 450,
                  child: Column(
                    children: [
                      // SEARCH BOX
                      TextField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search currency...",
                        ),
                        onChanged: (value) {
                          filtered = currencies
                              .where((c) => c.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                          setState(() {});
                        },
                      ),

                      const SizedBox(height: 12),

                      // LIST
                      currencies.isEmpty
                          ? const Expanded(
                          child: Center(child: CircularProgressIndicator()))
                          : Expanded(
                        child: ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final c = filtered[index];
                            return RadioListTile(
                              value: c.code,
                              groupValue: selectedCode,
                              title: Text("${c.code} - ${c.name}"),
                              secondary: Text(c.symbol,
                                  style: const TextStyle(fontSize: 18)),
                              onChanged: (value) {
                                selectedCode = value;
                                controller.text = value as String;
                                Navigator.pop(context);
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }


    @override
    Widget build(BuildContext context) {
      final user = widget.user!;
      return Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),

        // appBar: AppBar(
        //   elevation: 0,
        //   title: const Text("Edit Profile"),
        //   backgroundColor: Colors.transparent,
        //   foregroundColor: Colors.black,
        // ),

        body: SingleChildScrollView(
          child: Column(
            children: [

              _buildHeader(user),
              const SizedBox(height: 20),
              _buildFormCard(context),
            ],
          ),
        ),
      );
    }

    Widget _buildHeader(UserProfile user) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        // padding: const EdgeInsets.all(30),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => showAvatarPicker(context),
              child: CircleAvatar(
                radius: 42,
                backgroundColor: Colors.white,
                backgroundImage:
                AssetImage("assets/avatars/a$selectedAvatar.jpg")
              ),
            ),
            // CircleAvatar(
            //   radius: 42,
            //   backgroundColor: Colors.white,
            //   child: Text(
            //     user.firstName[0],
            //     style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            //   ),
            // ),
            const SizedBox(height: 10),
            Text(
              "${user.firstName} ${user.lastName}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              user.email,
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      );
    }



    Widget _buildFormCard(BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.06),
              blurRadius: 8,
              spreadRadius: 2,
            )
          ],
        ),
        child: Column(
          children: [
            _buildInput("First Name", firstNameCtrl),
            _buildInput("Last Name", lastNameCtrl),
            _buildInput("Email", emailCtrl, enabled: false),
            _buildInput("Time Zone", timeZoneCtrl,enabled: false),
            _buildInput(
              "Language",
              languageCtrl,
              onTap: () => showLanguagePicker(context),
            ),

            _buildInput(
              "Currency",
              currencyCtrl,
              onTap: () => showCurrencyPicker(context, currencyCtrl),
            ),


            const SizedBox(height: 22),

            _buildSaveButton(),
          ],
        ),
      );
    }

    Widget _buildInput(String label, TextEditingController controller, {bool enabled = true, VoidCallback? onTap,}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: onTap,
              child: AbsorbPointer(
                absorbing: onTap != null,
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: enabled ? const Color(0xFFF5F7FA) : Colors.grey.shade300,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildSaveButton() {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            backgroundColor: const Color(0xFF357ABD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () async {
            final body = <String, dynamic>{};

            // FIRST NAME
            if (firstNameCtrl.text.trim() != widget.user!.firstName) {
              body["first_name"] = firstNameCtrl.text.trim();
            }

            // LAST NAME
            if (lastNameCtrl.text.trim() != widget.user!.lastName) {
              body["last_name"] = lastNameCtrl.text.trim();
            }

            // LANGUAGE (convert labels to API code)
            final langInput = languageCtrl.text.trim().toLowerCase();

            final validLang = {
              "en": "en",
              "english": "en",

              "ar": "ar",
              "arabic": "ar",

              "ja": "ja",
              "japanese": "ja",
            };


            final input = languageCtrl.text.trim().toLowerCase();
            final langCode = validLang[input] ?? input;

            // final langCode = validLang[langInput] ?? langInput;

            if (langCode != widget.user!.preferredLanguage) {
              body["preferred_language"] = "en";
            }


            // CURRENCY — extract only code
            final selectedCurrencyText = currencyCtrl.text.trim();
            final code = RegExp(r'^[A-Z]{3}').stringMatch(selectedCurrencyText);

            if (code != null && code != widget.user!.currencyCode) {
              body["currency"] = code;
            }

            if (selectedAvatar != widget.user!.avatar) {
              body["avatar"] = selectedAvatar;
            }

            if (body.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("No changes to update")),
              );
              return;
            }

            final ok = await settingsController.updateUserProfile(body);

            if (ok) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile updated successfully")),
              );
              Navigator.pop(context, true);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Update failed")),
              );
            }
          },

          // onPressed: () async {
          //   // final body = <String, dynamic>{};
          //   // final body = <String, dynamic>{};
          //
          //   // if (firstNameCtrl.text.trim() != widget.user!.firstName) {
          //   //   body["first_name"] = firstNameCtrl.text.trim();
          //   // }
          //   // if (lastNameCtrl.text.trim() != widget.user!.lastName) {
          //   //   body["last_name"] = lastNameCtrl.text.trim();
          //   // }
          //   // if (languageCtrl.text.trim() != widget.user!.preferredLanguage) {
          //   //   body["preferred_language"] = languageCtrl.text.trim();
          //   // }
          //   // if (currencyCtrl.text.trim() != "${widget.user!.currencyCode} (${widget.user!.currencySymbol})") {
          //   //   body["currency"] = currencyCtrl.text.split(" ").first;
          //   // }
          //
          //   // if (body.isEmpty) {
          //   //   ScaffoldMessenger.of(context).showSnackBar(
          //   //     const SnackBar(content: Text("No changes to update")),
          //   //   );
          //   //   return;
          //   // }
          //
          //   final body = {
          //     "first_name": "KURI",
          //     "last_name": "HARAN",
          //     "preferred_language": "en",
          //     "currency": "AED",
          //     "avatar": 1,
          //   };
          //
          //   final ok = await settingsController.updateUserProfile(body);
          //
          //
          //   if (ok) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text("Profile updated successfully")),
          //     );
          //     Navigator.pop(context, true);
          //   } else {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text("Update failed")),
          //     );
          //   }
          // },


          child: const Text(
            "Save Changes",
            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
    }
  }
