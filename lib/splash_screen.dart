import 'package:flutter/material.dart';
import 'dart:math';
import 'main.dart'; // Import MainWrapper dari main.dart

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late Animation<Offset> _slideUpAnimation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: const Interval(0.2, 0.7, curve: Curves.elasticOut)),
    );
    
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: const Interval(0.5, 1.0, curve: Curves.easeInOutSine)),
    );
    
    _slideUpAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic)),
    );
    
    _animationController.forward();
    
    // Auto navigate after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainWrapper()),
        );
      }
    });
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF004D64), Color(0xFF006684), Color(0xFF0080A0)],
          ),
        ),
        child: Stack(
          children: [
            // Animated Floating Particles
            ...List.generate(30, (index) => _AnimatedParticle(
              index: index,
              delay: index * 0.1,
            )),
            
            // Animated Rotating Circles
            const _AnimatedRotatingCircle(
              size: 400,
              color: Color(0xFF006A6A),
              opacity: 0.15,
              duration: 20,
            ),
            const _AnimatedRotatingCircle(
              size: 300,
              color: Color(0xFF9DEEED),
              opacity: 0.1,
              duration: 15,
              reverse: true,
            ),
            const _AnimatedRotatingCircle(
              size: 200,
              color: Color(0xFFA2E1FF),
              opacity: 0.2,
              duration: 10,
            ),
            
            // Pulsing Wave Effect
            const _PulsingWaveEffect(),
            
            // Main Content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    
                    // Animated Logo with Glow
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: AnimatedBuilder(
                          animation: _glowAnimation,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFA0F0F0).withOpacity(0.5 * _glowAnimation.value),
                                    blurRadius: 30 * _glowAnimation.value,
                                    spreadRadius: 10 * _glowAnimation.value,
                                  ),
                                ],
                              ),
                              child: child,
                            );
                          },
                          child: _buildLogoBox(),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Animated Title
                    SlideTransition(
                      position: _slideUpAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Colors.white, Color(0xFFA0F0F0)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                'Smart Glove',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -1.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [const Color(0xFFA0F0F0).withOpacity(0.3), const Color(0xFFA2E1FF).withOpacity(0.1)],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'SIGN LANGUAGE TRANSLATOR',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFA2E1FF),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Animated Status Footer
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
                          CurvedAnimation(parent: _animationController, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
                        ),
                        child: _buildStatusFooter(),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoBox() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: const Icon(
        Icons.front_hand,
        size: 70,
        color: Colors.white,
      ),
    );
  }

  Widget _buildStatusFooter() {
    return Column(
      children: [
        // Animated Bluetooth Status
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _glowAnimation,
              builder: (context, child) {
                return Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA0F0F0),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFA0F0F0).withOpacity(0.8 * _glowAnimation.value),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            const Text(
              'Bluetooth Connectivity Initializing...',
              style: TextStyle(
                color: Color(0xE5A2E1FF),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        // Animated Progress Bar
        Container(
          width: 200,
          height: 2,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(2),
          ),
          child: AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, child) {
              return FractionallySizedBox(
                widthFactor: _glowAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFA0F0F0), Color(0xFFA2E1FF)],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            },
          ),
        ),
        
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallStatus('FIREBASE AUTH'),
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
              _buildSmallStatus('READY'),
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
              _buildSmallStatus('SYNCING'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallStatus(String text) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        );
      },
    );
  }
}

// Animated Floating Particles
class _AnimatedParticle extends StatefulWidget {
  final int index;
  final double delay;
  
  const _AnimatedParticle({required this.index, required this.delay});

  @override
  State<_AnimatedParticle> createState() => _AnimatedParticleState();
}

class _AnimatedParticleState extends State<_AnimatedParticle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late double _startX;
  late double _startY;
  late double _endX;
  late double _endY;
  late double _size;
  
  @override
  void initState() {
    super.initState();
    _startX = _random.nextDouble() * 1.0;
    _startY = _random.nextDouble() * 1.0;
    _endX = _startX + (_random.nextDouble() - 0.5) * 0.3;
    _endY = _startY - _random.nextDouble() * 0.5;
    _size = 2 + _random.nextDouble() * 4;
    
    _controller = AnimationController(
      duration: Duration(seconds: 3 + _random.nextInt(3)),
      vsync: this,
    )..forward();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        final x = _startX + (_endX - _startX) * progress;
        final y = _startY + (_endY - _startY) * progress;
        final opacity = (1 - progress) * 0.6;
        
        return Positioned(
          left: MediaQuery.of(context).size.width * x,
          top: MediaQuery.of(context).size.height * y,
          child: Opacity(
            opacity: opacity,
            child: Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                color: const Color(0xFFA0F0F0),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Animated Rotating Circle
class _AnimatedRotatingCircle extends StatefulWidget {
  final double size;
  final Color color;
  final double opacity;
  final int duration;
  final bool reverse;
  
  const _AnimatedRotatingCircle({
    required this.size,
    required this.color,
    required this.opacity,
    required this.duration,
    this.reverse = false,
  });

  @override
  State<_AnimatedRotatingCircle> createState() => _AnimatedRotatingCircleState();
}

class _AnimatedRotatingCircleState extends State<_AnimatedRotatingCircle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: MediaQuery.of(context).size.width / 2 - widget.size / 2,
          top: MediaQuery.of(context).size.height / 2 - widget.size / 2,
          child: Transform.rotate(
            angle: (widget.reverse ? -1 : 1) * _controller.value * 2 * 3.14159,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.color.withOpacity(widget.opacity),
                  width: 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Pulsing Wave Effect
class _PulsingWaveEffect extends StatefulWidget {
  const _PulsingWaveEffect();

  @override
  State<_PulsingWaveEffect> createState() => _PulsingWaveEffectState();
}

class _PulsingWaveEffectState extends State<_PulsingWaveEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = _controller.value;
        final scale = 1 + value * 0.3;
        final opacity = (1 - value) * 0.15;
        
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8 * scale,
            height: MediaQuery.of(context).size.width * 0.8 * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFA0F0F0).withOpacity(opacity),
            ),
          ),
        );
      },
    );
  }
}