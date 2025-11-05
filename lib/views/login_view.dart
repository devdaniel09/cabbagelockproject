import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../core/utils/responsive_helper.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController();

    final bool isDesktop = ResponsiveHelper.isDesktop(context);
    final padding = ResponsiveHelper.horizontalPadding(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                elevation: isDesktop ? 6 : 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const FlutterLogo(size: 80),
                      const SizedBox(height: 24),
                      Text(
                        "CabbageLock",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      CustomInput(
                          controller: controller.emailController,
                          label: 'Correo electrónico'),
                      const SizedBox(height: 12),
                      CustomInput(
                          controller: controller.passwordController,
                          label: 'Contraseña',
                          isPassword: true),
                      const SizedBox(height: 20),
                      CustomButton(
                          text: 'Ingresar',
                          onPressed: () => controller.login(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
