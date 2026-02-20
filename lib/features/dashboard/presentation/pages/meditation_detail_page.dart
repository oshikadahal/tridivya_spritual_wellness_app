import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MeditationDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String tag;
  final List<String>? aboutParagraphs;
  final List<Map<String, dynamic>>? focusAreas;
  final List<Map<String, dynamic>>? needs;
  final List<Map<String, dynamic>>? flow;

  const MeditationDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tag,
    this.aboutParagraphs,
    this.focusAreas,
    this.needs,
    this.flow,
  });

  @override
  State<MeditationDetailPage> createState() => _MeditationDetailPageState();
}

class _MeditationDetailPageState extends State<MeditationDetailPage> {
  late final VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isReady = false;
  String? _error;
  double _currentSpeed = 1.0;

  Color get _primary => const Color(0xFF7C4DFF);
  Color get _bg => const Color(0xFFF7F4FF);

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Widget _buildSectionTitle(String title, TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: Colors.grey.shade900),
        ),
        const SizedBox.shrink(),
      ],
    );
  }

  Future<void> _initializePlayer() async {
    try {
      _videoController = VideoPlayerController.asset('assets/videos/video.mp4');
      await _videoController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: true,
        allowedScreenSleep: false,
        playbackSpeeds: const [0.75, 1.0, 1.25, 1.5, 2.0],
        materialProgressColors: ChewieProgressColors(
          playedColor: _primary,
          handleColor: _primary,
          backgroundColor: Colors.white.withOpacity(0.2),
          bufferedColor: Colors.white70,
        ),
      );

      setState(() {
        _isReady = true;
      });
    } catch (e) {
      setState(() {
        _error = 'Unable to load the meditation video. Please try again.';
      });
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: _bg,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Meditation Session',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: _isReady ? () => _chewieController?.enterFullScreen() : null,
            icon: const Icon(Icons.fullscreen),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideo(textTheme),
            const SizedBox(height: 16),
            _buildHeader(textTheme),
            const SizedBox(height: 12),
            _buildMeta(textTheme),
            const SizedBox(height: 12),
            _buildFocusChips(textTheme),
            const SizedBox(height: 18),
            _buildActions(textTheme),
            const SizedBox(height: 18),
            _buildSectionTitle('Quick controls', textTheme),
            const SizedBox(height: 10),
            _buildSpeedControls(textTheme),
            const SizedBox(height: 22),
            _buildSectionTitle('About this meditation', textTheme),
            const SizedBox(height: 10),
            _buildAbout(textTheme),
            const SizedBox(height: 22),
            _buildSectionTitle('What you need', textTheme),
            const SizedBox(height: 12),
            _buildNeeds(textTheme),
            const SizedBox(height: 22),
            _buildSectionTitle('Session flow', textTheme),
            const SizedBox(height: 12),
            _buildFlow(textTheme),
            const SizedBox(height: 22),
            _buildSectionTitle('Benefits', textTheme),
            const SizedBox(height: 10),
            _buildBenefits(textTheme),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildVideo(TextTheme textTheme) {
    if (_error != null) {
      return Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            _error!,
            style: textTheme.bodyMedium?.copyWith(color: Colors.red.shade700),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: AspectRatio(
          aspectRatio: _isReady ? _videoController.value.aspectRatio : 16 / 9,
          child: _isReady
              ? Chewie(controller: _chewieController!)
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.tag.toUpperCase(),
            style: textTheme.labelSmall?.copyWith(
              color: _primary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.black,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          widget.subtitle,
          style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
        ),
      ],
    );
  }

  Widget _buildMeta(TextTheme textTheme) {
    final chips = [
      _MetaChip(icon: Icons.schedule, label: '12 mins'),
      _MetaChip(icon: Icons.headphones, label: 'Guided'),
      const _MetaChip(icon: Icons.self_improvement, label: 'Mindfulness'),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: chips,
    );
  }

  Widget _buildFocusChips(TextTheme textTheme) {
    final focus = widget.focusAreas ?? [
      {'icon': Icons.waves, 'label': 'Calm'},
      {'icon': Icons.bolt, 'label': 'Focus'},
      {'icon': Icons.air, 'label': 'Breath'},
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: focus
          .map(
            (item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item['icon'] as IconData, color: _primary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    item['label'] as String,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildActions(TextTheme textTheme) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: _isReady
                ? () {
                    if (_chewieController != null && !_videoController.value.isPlaying) {
                      _chewieController!.play();
                    }
                  }
                : null,
            icon: const Icon(Icons.play_arrow_rounded, size: 26),
            label: Text(
              _isReady && _videoController.value.isPlaying ? 'Playing' : 'Start Session',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: _primary.withOpacity(0.3)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _isReady
                    ? () {
                        final newPosition = _videoController.value.position - const Duration(seconds: 10);
                        _videoController.seekTo(newPosition < Duration.zero ? Duration.zero : newPosition);
                      }
                    : null,
                icon: Icon(Icons.replay_10, color: _primary),
                label: Text(
                  'Rewind 10s',
                  style: textTheme.bodyMedium?.copyWith(color: _primary, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: _primary.withOpacity(0.3)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _isReady
                    ? () {
                        final end = _videoController.value.duration;
                        final newPosition = _videoController.value.position + const Duration(seconds: 10);
                        _videoController.seekTo(newPosition > end ? end : newPosition);
                      }
                    : null,
                icon: Icon(Icons.forward_10, color: _primary),
                label: Text(
                  'Skip 10s',
                  style: textTheme.bodyMedium?.copyWith(color: _primary, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpeedControls(TextTheme textTheme) {
    const speeds = [0.75, 1.0, 1.25, 1.5, 2.0];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: speeds
          .map(
            (speed) => ChoiceChip(
              label: Text('${speed.toStringAsFixed(speed == speed.toInt() ? 0 : 2)}x'),
              selected: _currentSpeed == speed,
              onSelected: _isReady
                  ? (selected) {
                      if (selected) {
                        _videoController.setPlaybackSpeed(speed);
                        setState(() {
                          _currentSpeed = speed;
                        });
                      }
                    }
                  : null,
              selectedColor: _primary.withOpacity(0.12),
              labelStyle: textTheme.bodyMedium?.copyWith(
                color: _currentSpeed == speed ? _primary : Colors.grey.shade800,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildAbout(TextTheme textTheme) {
    final about = widget.aboutParagraphs ?? [
      'Settle into a calm, guided practice that blends mindful breathing with gentle awareness cues to clear morning fog and reduce anxious thoughts.',
      'Instructor Rahul leads you through steady breath pacing, body scanning, and visualization so you can start the day grounded and focused.',
      'Perfect when you need a quick reset before work, after a busy commute, or anytime you want to recharge without movement.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: about
          .map(
            (p) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                p,
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800, height: 1.45),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildNeeds(TextTheme textTheme) {
    final needs = widget.needs ?? [
      {'label': 'Headphones', 'icon': Icons.headphones},
      {'label': 'Quiet space', 'icon': Icons.nightlight_round},
    ];

    return Row(
      children: needs
          .map(
            (item) => Expanded(
              child: Container(
                margin: item == needs.first ? EdgeInsets.zero : const EdgeInsets.only(left: 12),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item['icon'] as IconData, color: _primary, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['label'] as String,
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildFlow(TextTheme textTheme) {
    final steps = widget.flow ?? [
      {'title': 'Arrival & breath count', 'time': '2 mins'},
      {'title': 'Body scan & tension release', 'time': '4 mins'},
      {'title': 'Visualization for clarity', 'time': '4 mins'},
      {'title': 'Closing affirmation', 'time': '2 mins'},
    ];

    return Column(
      children: steps.asMap().entries.map((entry) {
        final idx = entry.key + 1;
        final step = entry.value;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: _primary.withOpacity(0.4), width: 1.4),
                ),
                child: Center(
                  child: Text(
                    idx.toString().padLeft(2, '0'),
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: _primary),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  step['title'] as String,
                  style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700, color: Colors.grey.shade900),
                ),
              ),
              Text(
                step['time'] as String,
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBenefits(TextTheme textTheme) {
    final points = [
      'Reduces morning anxiety and racing thoughts',
      'Improves focus and decision-making clarity',
      'Eases physical tension through paced breathing',
      'Creates a calm baseline for the rest of the day',
    ];

    return Column(
      children: points
          .map(
            (p) => Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: _primary, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      p,
                      style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade800),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade800),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
          ),
        ],
      ),
    );
  }
}
