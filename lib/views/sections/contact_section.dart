import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../viewmodels/contact_viewmodel.dart';
import '../../widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ContactViewModel>();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: "Get In Touch"),
          isMobile
              ? Column(
                  children: [
                    _buildContactInfo(context),
                    const SizedBox(height: 60),
                    _buildContactForm(context, viewModel),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo(context)),
                    const SizedBox(width: 80),
                    Expanded(flex: 1, child: _buildContactForm(context, viewModel)),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Let's discuss your next project",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 20),
        const Text(
          "I'm always open to discussing new projects, creative ideas or opportunities to be part of your visions.",
          style: TextStyle(fontSize: 16, color: AppColors.textSecondary, height: 1.6),
        ),
        const SizedBox(height: 40),
        _buildContactCard(Icons.email, "Email", "umairahmad03003@gmail.com"),
        _buildContactCard(FontAwesomeIcons.whatsapp, "WhatsApp", "03003393940"),
        _buildContactCard(FontAwesomeIcons.github, "GitHub", "github.com/UmairAhmad03003"),
        _buildContactCard(FontAwesomeIcons.youtube, "YouTube", "@CodeFlowUmair"),
      ],
    );
  }

  Widget _buildContactCard(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.secondaryAccent, size: 24),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(BuildContext context, ContactViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryAccent.withOpacity(0.05),
            blurRadius: 30,
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: viewModel.nameController,
            hintText: "Your Name",
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: viewModel.emailController,
            hintText: "Email Address",
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: viewModel.messageController,
            hintText: "Message",
            icon: Icons.message_outlined,
            maxLines: 5,
          ),
          const SizedBox(height: 30),
          if (viewModel.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(viewModel.errorMessage!, style: const TextStyle(color: Colors.red)),
            ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: viewModel.isLoading ? null : () => viewModel.submitContact(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryAccent,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: viewModel.isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text("Send Message", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          if (viewModel.isSent)
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: Text("Message sent successfully!", style: TextStyle(color: AppColors.secondaryAccent))),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        prefixIcon: Icon(icon, color: AppColors.primaryAccent),
        filled: true,
        fillColor: AppColors.background,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryAccent),
        ),
      ),
    );
  }
}
