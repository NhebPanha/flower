import 'dart:io';

import 'package:flower/core/utils/app_label/app_label.dart';
import 'package:flower/features/user/presentation/bloc/user_bloc.dart';
import 'package:flower/features/user/presentation/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final dynamic user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.user.name ?? "");
    phoneController = TextEditingController(text: widget.user.phone ?? "");
    addressController = TextEditingController(text: widget.user.address ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  // ================= PICK IMAGE =================
  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  // ================= SHOW OPTIONS =================
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (bottomContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(bottomContext);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _pickImage(ImageSource.gallery);
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(bottomContext);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _pickImage(ImageSource.camera);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String oldImage = widget.user.image ?? "";

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= PROFILE IMAGE =================
            GestureDetector(
              onTap: _showImagePickerOptions,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (oldImage.isNotEmpty ? NetworkImage(oldImage) : null)
                          as ImageProvider?,
                child: (_imageFile == null && oldImage.isEmpty)
                    ? const Icon(Icons.camera_alt, size: 30)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            // ================= NAME =================
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // ================= PHONE =================
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // ================= ADDRESS =================
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            // ================= SAVE BUTTON =================
            InkWell(
              onTap: () {
                context.read<UserBloc>().add(
                  UpdateUserEvent(
                    name: nameController.text.trim(),
                    phone: phoneController.text.trim(),
                    address: addressController.text.trim(),

                    /// NEW IMAGE OR OLD IMAGE
                    image: _imageFile?.path ?? oldImage,
                  ),
                );

                Navigator.pop(context);
              },
              child: Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 189, 189, 189),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF0000).withValues(alpha: 0.5),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
