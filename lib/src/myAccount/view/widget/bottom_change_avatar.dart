import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_success_snackbar.dart';

class BottomChangeAvatar extends StatefulWidget {
  const BottomChangeAvatar({super.key});

  @override
  State<BottomChangeAvatar> createState() => _BottomChangeAvatarState();
}

class _BottomChangeAvatarState extends State<BottomChangeAvatar> {
  final String user_male = "assets/images/myAccount/user_male.png";
  final String user_female = "assets/images/myAccount/user_female.png";
  int selectedGender = 0;
  int selectedAvatar = 0;
  bool isLoading = false;

  final avatars = [
    "assets/images/myAccount/avatar_icons/a1.png",
    "assets/images/myAccount/avatar_icons/a2.png",
    "assets/images/myAccount/avatar_icons/a3.png",
    "assets/images/myAccount/avatar_icons/a4.png",
    "assets/images/myAccount/avatar_icons/a5.png",
    "assets/images/myAccount/avatar_icons/a6.png",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: const BoxDecoration(
            color: ColorPalette.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),

          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// TITLE
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: ColorPalette.surface,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Change Avatar",
                      style: TextStyle(
                        color: ColorPalette.textPrimary,
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                /// PREVIEW AVATAR
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      avatars[selectedAvatar],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// GENDER
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "GENDER",
                    style: TextStyle(
                      color: ColorPalette.textSecondary,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(child: _genderButton("Male", 0, user_male)),

                    const SizedBox(width: 8),

                    Expanded(child: _genderButton("Female", 1, user_female)),
                  ],
                ),

                const SizedBox(height: 24),

                /// SELECT AVATAR
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "SELECT AVATAR",
                    style: TextStyle(
                      color: ColorPalette.textSecondary,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// AVATAR GRID
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: avatars.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAvatar = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: selectedAvatar == index
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(avatars[index], fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                /// UPDATE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await Future.delayed(const Duration(seconds: 2));

                      setState(() {
                        isLoading = false;
                      });

                      Navigator.pop(context, avatars[selectedAvatar]);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          content: CustomSuccessSnackbar(
                            message: "Changed Avatar Successfully",
                          ),
                        ),
                      );
                    },

                    child: const Text(
                      "Update Avatar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// LOADER
        if (isLoading)
          Container(
            color: Colors.black45,
            child: const Center(
              child: CircularProgressIndicator(color: ColorPalette.primary),
            ),
          ),
      ],
    );
  }

  Widget _genderButton(String text, int index, String iconPath) {
    final selected = selectedGender == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = index;
        });
      },
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFDFC45C) : Colors.white10,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 16, height: 16),

            const SizedBox(width: 6),

            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
