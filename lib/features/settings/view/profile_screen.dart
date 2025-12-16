  import 'package:expense_tracker/features/settings/view/select_language.dart';
import 'package:flutter/material.dart';
  import '../../../core/localization/app_localization_controller.dart';
import '../../../utils/devices/get_localization_provider.dart';
import '../controller/currency_provider.dart';
import '../controller/settings_controller.dart';
  import '../model/user_profile.dart';
  import 'package:provider/provider.dart';


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


    String languageLabel(String code) {
      switch (code) {
        case 'en':
          return 'English';
        case 'ja':
          return 'Japanese';
        case 'ar':
          return 'Arabic';
        default:
          return code;
      }
    }


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
      selectedAvatar = u.avatar ?? 1;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final langProvider =
        context.read<AppLocalizationController>();

        setState(() {
          languageCtrl.text = languageLabel(langProvider.appLanguage);
        });
      });

    }


    Future<void> showAvatarPicker(BuildContext context) async {
      final localizationController = getLocalizationController(
        context,
        listen: false,
      );
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text( localizationController.getTextValue(
              "PROFILE_CHOOSE_AVATAR",
            ),),
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
                        AssetImage("assets/avatars/a$avatarNo.jpg"),
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
      final localizationController = getLocalizationController(
        context,
        listen: false,
      );
      final List<Map<String, String>> languages = [
        {"label": "English", "code": "en"},
        {"label": "Arabic", "code": "ar"},
        {"label": "Japanese", "code": "ja"}, // FIXED
      ];


      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text( localizationController.getTextValue(
              "PROFILE_SELECT_LANGUAGE",
            ),),
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
      final localizationController = getLocalizationController(
        context,
        listen: false,
      );
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
                title:  Text( localizationController.getTextValue(
                  "PROFILE_SELECT_CURRENCY",
                ),),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 450,
                  child: Column(
                    children: [
                      // SEARCH BOX
                      TextField(
                        decoration:  InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: localizationController.getTextValue(
                            "PROFILE_SEARCH_CURRENCY",
                          ),
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
                              onChanged: (value) async {
                                final currencyProvider = context.read<CurrencyProvider>();

                                selectedCode = value as String;
                                controller.text = "${c.code} (${c.symbol})";

                                await currencyProvider.setCurrency(
                                  code: c.code,
                                  symbol: c.symbol,
                                );

                                Navigator.pop(context);
                                setState(() {});
                              },

                              // onChanged: (value) {
                              //   selectedCode = value;
                              //   controller.text = value as String;
                              //   Navigator.pop(context);
                              //   setState(() {});
                              // },
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
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/avatars/a$selectedAvatar.jpg"),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ],
              ),
            ),
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

    // Widget _buildHeader(UserProfile user) {
    //   return Container(
    //     padding: const EdgeInsets.symmetric(vertical: 40),
    //     // padding: const EdgeInsets.all(30),
    //     width: double.infinity,
    //     decoration: const BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
    //         begin: Alignment.topLeft,
    //         end: Alignment.bottomRight,
    //       ),
    //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
    //     ),
    //     child: Column(
    //       children: [
    //         GestureDetector(
    //           onTap: () => showAvatarPicker(context),
    //           child: CircleAvatar(
    //             radius: 42,
    //             backgroundColor: Colors.white,
    //             backgroundImage:
    //             AssetImage("assets/avatars/a$selectedAvatar.jpg")
    //           ),
    //         ),
    //         // CircleAvatar(
    //         //   radius: 42,
    //         //   backgroundColor: Colors.white,
    //         //   child: Text(
    //         //     user.firstName[0],
    //         //     style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    //         //   ),
    //         // ),
    //         const SizedBox(height: 10),
    //         Text(
    //           "${user.firstName} ${user.lastName}",
    //           style: const TextStyle(
    //             color: Colors.white,
    //             fontSize: 20,
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //         Text(
    //           user.email,
    //           style: const TextStyle(color: Colors.white70),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    //


    Widget _buildFormCard(BuildContext context) {
      final localizationController = getLocalizationController(
        context,
        listen: false,
      );
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
            _buildInput(localizationController.getTextValue(
              "PROFILE_FIRST_NAME",
            ), firstNameCtrl),
            _buildInput(localizationController.getTextValue(
              "PROFILE_LAST_NAME",
            ), lastNameCtrl),
            _buildInput(localizationController.getTextValue(
              "PROFILE_EMAIL",
            ), emailCtrl, enabled: false),
            _buildInput(localizationController.getTextValue(
              "PROFILE_TIME_ZONE",
            ), timeZoneCtrl,enabled: false),
            _buildInput(
              localizationController.getTextValue("PROFILE_LANGUAGE"),
              languageCtrl,
              onTap: () async {
                final selectedLang = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (_) => const SelectLanguage()),
                );

                if (selectedLang != null) {
                  setState(() {
                    languageCtrl.text = selectedLang; //  updates UI
                  });
                }
              },
            ),

            // _buildInput(
            //   localizationController.getTextValue("PROFILE_LANGUAGE"),
            //   languageCtrl,
            //   onTap: () async {
            //     // Navigate and wait for selected language
            //     final selectedLanguage = await Navigator.push<String>(
            //       context,
            //       MaterialPageRoute(builder: (context) => const SelectLanguage()),
            //     );
            //
            //     if (selectedLanguage != null) {
            //       setState(() {
            //         languageCtrl.text = selectedLanguage;
            //       });
            //     }
            //   },
            // ),

            // _buildInput(
            //   localizationController.getTextValue(
            //     "PROFILE_LANGUAGE",
            //   ),
            //   languageCtrl,
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const SelectLanguage()),
            //     );
            //   },
            // ),

            _buildInput(
              localizationController.getTextValue(
                "PROFILE_CURRENCY",
              ),
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
      final localizationController =
      getLocalizationController(context, listen: false);

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
            final settingsController =
            context.read<SettingsController>(); // ✅ IMPORTANT

            final body = <String, dynamic>{};

            if (firstNameCtrl.text.trim() != widget.user!.firstName) {
              body["first_name"] = firstNameCtrl.text.trim();
            }

            if (lastNameCtrl.text.trim() != widget.user!.lastName) {
              body["last_name"] = lastNameCtrl.text.trim();
            }

            final code =
            RegExp(r'^[A-Z]{3}').stringMatch(currencyCtrl.text.trim());
            if (code != null && code != widget.user!.currencyCode) {
              body["currency"] = code;
            }

            if (selectedAvatar != widget.user!.avatar) {
              body["avatar"] = selectedAvatar;
            }

            if (body.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localizationController.getTextValue("PROFILE_NO_CHANGES"),
                  ),
                ),
              );
              return;
            }

            final ok = await settingsController.updateUserProfile(body);

            if (!context.mounted) return;

            if (ok) {
              // 🔥 REFRESH PROFILE DATA
              await settingsController.fetchUserProfile();

              final currencyProvider = context.read<CurrencyProvider>();
              final updatedUser = settingsController.userProfile!;

              await currencyProvider.setCurrency(
                code: updatedUser.currencyCode,
                symbol: updatedUser.currencySymbol,
              );


              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localizationController.getTextValue(
                      "PROFILE_UPDATE_SUCCESS",
                    ),
                  ),
                ),
              );

              Navigator.pop(context, true); // ✅ return success
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    localizationController.getTextValue(
                      "PROFILE_UPDATE_FAILED",
                    ),
                  ),
                ),
              );
            }
          },
          child: Text(
            localizationController.getTextValue("PROFILE_SAVE_CHANGES"),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

  }
