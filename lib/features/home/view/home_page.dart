import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/config/styles/colors.dart';
import '../../../core/utils/shared/constant/assets_path.dart';
import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              final isTablet =
                  constraints.maxWidth >= 600 && constraints.maxWidth < 1200;

              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: isMobile ? 20 : 30)
                            .animate()
                            .fadeIn(delay: 100.ms),
                        _buildMainCard(
                            constraints, provider, isMobile, isTablet),
                      ],
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.1, end: 0, curve: Curves.easeOut);
            },
          );
        },
      ),
    );
  }

  Widget _buildMainCard(BoxConstraints constraints, HomeProvider provider,
      bool isMobile, bool isTablet) {
    final cardWidth = isMobile
        ? constraints.maxWidth * 0.95
        : isTablet
            ? constraints.maxWidth * 0.85
            : constraints.maxWidth * 0.7;

    final cardHeight = isMobile ? 400.0 : 290.0;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFF0E4B6),
            Color(0xFFfffaf0),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 6,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
      width: cardWidth,
      height: cardHeight,
      child: _buildWelcomeSection(
          constraints, provider.currentTime, isMobile, isTablet),
    )
        .animate()
        .scaleXY(begin: 0.95, end: 1, delay: 200.ms, curve: Curves.easeOutBack);
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required bool isMobile,
    required int delay,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color(0xB5F8E2D0),
              Color(0xFFfffaf0),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.grey[100]!),
        ),
        child: Row(
          children: [
            Container(
              width: isMobile ? 32.0 : 40.0,
              height: isMobile ? 32.0 : 40.0,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: isMobile ? 16.0 : 20.0),
            ),
            SizedBox(width: isMobile ? 8.0 : 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'poppinsRegular',
                    fontSize: isMobile ? 8.0 : 10.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: isMobile ? 8.0 : 10.0,
                    fontFamily: 'poppinsRegular',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(delay: (delay * 100).ms)
          .slideX(begin: 0.2, end: 0, delay: (delay * 100).ms),
    );
  }

  Widget _buildWelcomeSection(
      BoxConstraints constraints, String time, bool isMobile, bool isTablet) {
    return isMobile
        ? _buildMobileLayout(constraints, time)
        : _buildDesktopTabletLayout(constraints, time, isTablet);
  }

  Widget _buildMobileLayout(BoxConstraints constraints, String time) {
    return Column(
      children: [
        // Welcome text
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Welcome to',
              style: TextStyle(
                color: Color(0xFF1e3a5f),
                fontSize: 14,
                fontFamily: 'poppinsSemiBold',
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
            const SizedBox(height: 8),
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Color(0xFF1e3a5f),
                    Color(0xFF1e3a5f),
                    Color(0xFFffd100),
                  ],
                ).createShader(bounds);
              },
              child: const Text(
                'Payment Apps',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppinsSemiBold',
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 400.ms).scaleXY(begin: 0.8, end: 1),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Image
        Container(
          height: constraints.maxHeight * 0.3,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              "assets/images/card_bg.jpg",
              fit: BoxFit.cover,
            ).animate().fadeIn(delay: 500.ms).scaleXY(begin: 0.9, end: 1),
          ),
        ),

        const SizedBox(height: 24),

        // Info cards
        Row(
          children: [
            _buildInfoCard(
              icon: Icons.calendar_today_outlined,
              title: 'Date',
              value: DateFormat('MMM d, y').format(DateTime.now()),
              color: const Color(0xFF1e3a5f),
              isMobile: true,
              delay: 6,
            ),
            const SizedBox(width: 12),
            _buildInfoCard(
              icon: Icons.access_time_outlined,
              title: 'Time',
              value: time,
              color: const Color(0xFFffd100),
              isMobile: true,
              delay: 7,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(
      BoxConstraints constraints, String time, bool isTablet) {
    return Row(
      children: [
        SizedBox(
          width: isTablet
              ? constraints.maxWidth * 0.5
              : constraints.maxWidth * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          const Text(
                            'Welcome to',
                            style: TextStyle(
                              color: Color(0xFF1e3a5f),
                              fontSize: 14,
                              fontFamily: 'poppinsSemiBold',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                              .animate()
                              .fadeIn(delay: 300.ms)
                              .slideY(begin: 0.2, end: 0),
                          const SizedBox(height: 8),
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFF1e3a5f),
                                  Color(0xFF1e3a5f),
                                  Color(0xFFffd100),
                                ],
                              ).createShader(bounds);
                            },
                            child: Text(
                              'Payment Application',
                              style: TextStyle(
                                fontSize: isTablet ? 20.0 : 24.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppinsSemiBold',
                                color: Colors.white,
                              ),
                            )
                                .animate()
                                .fadeIn(delay: 400.ms)
                                .scaleXY(begin: 0.8, end: 1),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  _buildInfoCard(
                    icon: Icons.calendar_today_outlined,
                    title: 'Date',
                    value:
                        DateFormat('MMMM d, y | EEEE').format(DateTime.now()),
                    color: const Color(0xFF1e3a5f),
                    isMobile: false,
                    delay: 6,
                  ),
                  SizedBox(width: isTablet ? 16.0 : 24.0),
                  _buildInfoCard(
                    icon: Icons.access_time_outlined,
                    title: 'Time',
                    value: time,
                    color: const Color(0xFFffd100),
                    isMobile: false,
                    delay: 7,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 8.0 : 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(isTablet ? 24.0 : 32.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isTablet ? 24.0 : 32.0),
                child: Image.asset(
                  "assets/images/card_bg.jpg",
                  fit: BoxFit.cover,
                ).animate().fadeIn(delay: 500.ms).scaleXY(begin: 0.9, end: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
