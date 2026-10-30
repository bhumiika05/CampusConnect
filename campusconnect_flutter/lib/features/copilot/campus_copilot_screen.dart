import 'package:flutter/material.dart';
import 'package:campusconnect_client/campusconnect_client.dart';
import '../../client.dart';
import '../../core/services/session_service.dart';
import '../../core/theme/app_colors.dart';
import '../events/event_details_screen.dart';
import '../study_buddy/widgets/send_study_request_dialog.dart';

class CampusCopilotScreen extends StatefulWidget {
  final String? initialPrompt;

  const CampusCopilotScreen({super.key, this.initialPrompt});

  @override
  State<CampusCopilotScreen> createState() => _CampusCopilotScreenState();
}

class _ChatMessage {
  final bool isUser;
  final String text;
  final List<CopilotActionCard> cards;
  final DateTime timestamp;

  _ChatMessage({
    required this.isUser,
    required this.text,
    this.cards = const [],
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class _CampusCopilotScreenState extends State<CampusCopilotScreen> {
  final List<_ChatMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<String> _suggestedPrompts = [
    'What should I do this week?',
    'Find study partners for AI',
    'Show upcoming campus workshops',
    'Find projects needing Flutter',
  ];

  @override
  void initState() {
    super.initState();
    _initWelcome();
    if (widget.initialPrompt != null && widget.initialPrompt!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sendMessage(widget.initialPrompt!);
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initWelcome() {
    final currentStudent = SessionService.instance.currentStudent;
    final firstName = currentStudent?.name.split(' ').first ?? 'there';

    _messages.add(
      _ChatMessage(
        isUser: false,
        text:
            '### 👋 Welcome, $firstName!\n\nI am your **AI Campus Copilot**. I analyze live campus workshops, active study groups, and open project teams to guide your campus life.\n\nAsk me anything or tap one of the suggested prompts below to plan your week!',
      ),
    );
  }

  Future<void> _sendMessage(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty || _isLoading) return;

    final student = SessionService.instance.currentStudent;
    if (student?.id == null) return;

    _inputController.clear();
    setState(() {
      _messages.add(_ChatMessage(isUser: true, text: trimmed));
      _isLoading = true;
    });
    _scrollToBottom();

    try {
      final response = await client.copilot.askCopilot(student!.id!, trimmed);

      if (mounted) {
        setState(() {
          _messages.add(
            _ChatMessage(
              isUser: false,
              text: response.reply,
              cards: response.recommendedCards,
            ),
          );
          if (response.suggestedPrompts.isNotEmpty) {
            _suggestedPrompts = response.suggestedPrompts;
          }
          _isLoading = false;
        });
        _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(
            _ChatMessage(
              isUser: false,
              text: '⚠️ Sorry, I encountered an issue retrieving recommendations: $e',
            ),
          );
          _isLoading = false;
        });
        _scrollToBottom();
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleCardAction(CopilotActionCard card) async {
    final student = SessionService.instance.currentStudent;
    if (student?.id == null) return;

    switch (card.cardType) {
      case 'study_buddy':
        if (card.referenceId == null) return;
        try {
          final profile = await client.profile.getProfileById(card.referenceId!);
          if (profile != null && mounted) {
            SendStudyRequestDialog.show(context, profile);
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open profile: $e')),
            );
          }
        }
        break;

      case 'event':
        if (card.referenceId == null) return;
        try {
          final event = await client.event.getEventById(card.referenceId!);
          if (event != null && mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(event: event),
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open event: $e')),
            );
          }
        }
        break;

      case 'project':
        if (card.referenceId == null) return;
        final messageController = TextEditingController(
          text: 'Hi! I found your project through AI Campus Copilot and would love to contribute.',
        );
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Apply to "${card.title}"'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Send an application to the project creator:'),
                const SizedBox(height: 12),
                TextField(
                  controller: messageController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    filled: true,
                    fillColor: AppColors.surfaceAlt,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Send Application'),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          try {
            await client.collaboration.sendRequest(
              card.referenceId!,
              student!.id!,
              messageController.text,
            );
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Application submitted successfully! 🚀'),
                  backgroundColor: AppColors.success,
                ),
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Application failed: $e')),
              );
            }
          }
        }
        break;

      case 'planner':
        try {
          await client.copilot.syncCopilotRecommendationsToPlanner(student!.id!);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Synced to My Campus Week! 🗓️ Check your planner tab.'),
                backgroundColor: AppColors.secondaryPurple,
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to sync to planner: $e')),
            );
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                gradient: AppColors.vibrantCardGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Campus Copilot',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Connected to live campus records',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat message list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(msg);
              },
            ),
          ),

          // Loading indicator
          if (_isLoading)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryPurpleSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.secondaryPurple,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Campus Copilot is searching live campus records...',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

          // Quick Prompt Chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: _suggestedPrompts.map((prompt) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          onPressed: () => _sendMessage(prompt),
                          avatar: const Icon(
                            Icons.bolt_rounded,
                            size: 14,
                            color: AppColors.secondaryPurple,
                          ),
                          label: Text(
                            prompt,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          backgroundColor: AppColors.surfaceAlt,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: AppColors.border),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),

                // Text Input Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.surfaceAlt,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: TextField(
                            controller: _inputController,
                            onSubmitted: _sendMessage,
                            decoration: const InputDecoration(
                              hintText: 'Ask Copilot about people, events, projects...',
                              hintStyle: TextStyle(
                                fontSize: 13,
                                color: AppColors.textMuted,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.vibrantCardGradient,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_upward_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () => _sendMessage(_inputController.text),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage msg) {
    if (msg.isUser) {
      return Container(
        margin: const EdgeInsets.only(bottom: 12, left: 60),
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: AppColors.vibrantCardGradient,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: Text(
            msg.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    // Copilot Response Bubble
    return Container(
      margin: const EdgeInsets.only(bottom: 16, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: AppColors.vibrantCardGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Campus Copilot',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _renderFormattedText(msg.text),
                if (msg.cards.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  const Divider(color: AppColors.divider),
                  const SizedBox(height: 8),
                  ...msg.cards.map(_buildActionCard),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderFormattedText(String text) {
    // Simple markdown-style line renderer
    final lines = text.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.startsWith('### ')) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              line.replaceFirst('### ', ''),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          );
        } else if (line.startsWith('* ')) {
          return Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontWeight: FontWeight.w800)),
                Expanded(
                  child: Text(
                    line.replaceFirst('* ', '').replaceAll('**', ''),
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (line.trim().isEmpty) {
          return const SizedBox(height: 6);
        } else {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              line.replaceAll('**', ''),
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: AppColors.textPrimary,
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  Widget _buildActionCard(CopilotActionCard card) {
    IconData iconData;
    Color iconColor;
    Color bgColor;

    switch (card.cardType) {
      case 'study_buddy':
        iconData = Icons.person_search_rounded;
        iconColor = AppColors.secondaryPurple;
        bgColor = AppColors.secondaryPurpleSoft;
        break;
      case 'event':
        iconData = Icons.event_available_rounded;
        iconColor = const Color(0xFFF97316);
        bgColor = const Color(0xFFFFF7ED);
        break;
      case 'project':
        iconData = Icons.rocket_launch_rounded;
        iconColor = AppColors.accentLightBlue;
        bgColor = AppColors.accentSkyLight;
        break;
      case 'planner':
      default:
        iconData = Icons.calendar_month_rounded;
        iconColor = AppColors.success;
        bgColor = AppColors.successLight;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        card.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (card.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: iconColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          card.badge!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: iconColor,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  card.subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => _handleCardAction(card),
            style: ElevatedButton.styleFrom(
              backgroundColor: iconColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              minimumSize: const Size(60, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              card.actionLabel ?? 'Action',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
