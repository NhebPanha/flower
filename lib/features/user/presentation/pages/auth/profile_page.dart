import 'dart:io';
import 'package:flower/core/utils/app_label/app_label.dart';
import 'package:flower/features/user/presentation/bloc/user_bloc.dart';
import 'package:flower/features/user/presentation/bloc/user_event.dart';
import 'package:flower/features/user/presentation/bloc/user_state.dart';
import 'package:flower/features/user/presentation/pages/auth/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? selectedImage;

  @override
  void initState() {
    super.initState();

    // ✅ FIX: load user (NOT update)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(LoadUserEvent());
    });
  }

  // 📷 PICK IMAGE
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });

      await updateProfileImage(); // auto upload
    }
  }

  // ☁️ UPLOAD TO SUPABASE
  Future<String?> uploadImage(File file) async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      final fileName = "${user!.id}.png";

      await supabase.storage
          .from('avatars')
          .upload(fileName, file, fileOptions: const FileOptions(upsert: true));

      final url = supabase.storage.from('avatars').getPublicUrl(fileName);

      return url;
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  // 🔄 UPDATE IMAGE IN DB
  Future<void> updateProfileImage() async {
    if (selectedImage == null) return;

    final url = await uploadImage(selectedImage!);

    if (url == null) return;

    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    await supabase.from('users').update({'image': url}).eq('id', user!.id);

    // reload user
    context.read<UserBloc>().add(LoadUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserLoaded) {
            final user = state.user;

            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // 🔙 Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back),
                        Spacer(),
                        Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        SizedBox(width: 24),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 👤 AVATAR WITH EDIT
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : NetworkImage(user.image) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // 👤 NAME
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // 📊 STATS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          AppLabel(text: "1,089"),
                          AppLabel(text: "Followers"),
                        ],
                      ),
                      SizedBox(width: 30),
                      Row(
                        children: [
                          AppLabel(text: "275"),
                          AppLabel(text: "Following"),
                        ],
                      ),

                      SizedBox(width: 30),
                      Row(
                        children: [
                          AppLabel(text: "10"),
                          AppLabel(text: "Events"),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 📄 ABOUT
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLabel(text: "About Me", fontWeight: FontWeight.bold),
                        SizedBox(height: 10),
                        AppLabel(
                          text: "This is your profile description.",
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  Spacer(),
                  // ✏️ EDIT BUTTON
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfilePage(user: user),
                        ),
                      );
                    },
                    child: Container(
                      height: 45,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 189, 189, 189),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFFF0000,
                            ).withValues(alpha: 0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          width: 0.5,
                        ),
                      ),
                      child: const Center(
                        child: AppLabel(
                          text: "Edit Profile",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 20),
                ],
              ),
            );
          }

          return Center(child: AppLabel(text: "Error"));
        },
      ),
    );
  }
}
