import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../data/drug_data.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({super.key});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  String _selectedTopic = 'ppis';
  List<Map<String, dynamic>> _flashcards = [];
  final CardSwiperController _controller = CardSwiperController();

  @override
  void initState() {
    super.initState();
    _loadFlashcards();
  }

  void _loadFlashcards() {
    // Generate flashcards from drug data
    final flashcards = <Map<String, dynamic>>[];
    
    for (var drugClass in drugClasses) {
      if (drugClass['id'] == _selectedTopic) {
        for (var drug in drugClass['drugs']) {
          flashcards.addAll([
            {
              'front': 'What is the mechanism of ${drug['name']}?',
              'back': drug['mechanism'],
              'category': 'Mechanism',
            },
            {
              'front': 'What class does ${drug['name']} belong to?',
              'back': drug['class'],
              'category': 'Class',
            },
            {
              'front': 'What are the main uses of ${drug['name']}?',
              'back': (drug['clinical_use'] as List<String>?)?.join(', ') ?? 'Various uses',
              'category': 'Uses',
            },
            {
              'front': 'What are side effects of ${drug['name']}?',
              'back': (drug['side_effects'] as List<String>?)?.join(', ') ?? 'Various side effects',
              'category': 'Side Effects',
            },
            {
              'front': 'Key exam fact about ${drug['name']}:',
              'back': drug['key_exam_fact'],
              'category': 'Exam Fact',
            },
          ]);
        }
        break;
      }
    }
    
    setState(() {
      _flashcards = flashcards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Topic Selector
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: DropdownButtonFormField<String>(
              value: _selectedTopic,
              decoration: const InputDecoration(labelText: 'Select Drug Class'),
              items: drugClasses.map((drugClass) => 
                DropdownMenuItem(value: drugClass['id'], child: Text(drugClass['name']))
              ).toList(),
              onChanged: (value) {
                setState(() => _selectedTopic = value!);
                _loadFlashcards();
              },
            ),
          ),
          
          // Flashcard Display
          Expanded(
            child: _flashcards.isEmpty
              ? const Center(child: Text('No flashcards available'))
              : CardSwiper(
                  controller: _controller,
                  cardsCount: _flashcards.length,
                  onSwipe: _onSwipe,
                  numberOfCardsDisplayed: 3,
                  backCardOffset: const Offset(40, 40),
                  padding: const EdgeInsets.all(24),
                  cardBuilder: (context, index, percentThresholdX, percentThresholdY) => 
                    _buildFlashcard(_flashcards[index], percentThresholdX),
                ),
          ),
          
          // Controls
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _controller.swipe(CardSwiperDirection.left),
                  icon: const Icon(Icons.close, color: Colors.red),
                  label: const Text('Need Review'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: () => _controller.swipe(CardSwiperDirection.right),
                  icon: const Icon(Icons.check, color: Colors.green),
                  label: const Text('Know It'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashcard(Map<String, dynamic> card, double percentThresholdX) {
    final isFlipped = percentThresholdX < 0; // Flip when swiping left
    
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        height: 300,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(card['category']),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                card['category'],
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isFlipped ? card['back'] : card['front'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              isFlipped ? '👆 Tap to flip back' : '👆 Tap to see answer',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    const colors = {
      'Mechanism': Colors.blue,
      'Class': Colors.green,
      'Uses': Colors.orange,
      'Side Effects': Colors.red,
      'Exam Fact': Colors.purple,
    };
    return colors[category] ?? Colors.grey;
  }

  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    // Handle swipe actions (know it vs need review)
    final card = _flashcards[previousIndex];
    final knewIt = direction == CardSwiperDirection.right;
    
    // In a real app, this would update spaced repetition algorithm
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(knewIt ? '✅ Good job!' : '🔄 Will review again soon'),
        duration: const Duration(seconds: 1),
      ),
    );
    
    return true;
  }
}