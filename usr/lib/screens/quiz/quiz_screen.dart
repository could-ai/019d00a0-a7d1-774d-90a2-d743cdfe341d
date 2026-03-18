import 'package:flutter/material.dart';
import '../../providers/app_provider.dart';
import '../../data/drug_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String _selectedTopic = 'ppis';
  String _selectedDifficulty = 'intermediate';
  List<Map<String, dynamic>> _questions = [];
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  int _score = 0;
  bool _quizCompleted = false;

  final Map<String, List<Map<String, dynamic>>> _quizData = {
    'ppis': [
      {
        'question': 'What is the mechanism of action of PPIs?',
        'options': ['Block H2 receptors', 'Directly neutralize acid', 'Inhibit proton pump', 'Stimulate bicarbonate'],
        'correct': 2,
        'explanation': 'PPIs irreversibly inhibit H+/K+ ATPase (proton pump)'
      },
      {
        'question': 'Which PPI has fewest drug interactions?',
        'options': ['Omeprazole', 'Esomeprazole', 'Pantoprazole', 'Lansoprazole'],
        'correct': 2,
        'explanation': 'Pantoprazole has lowest CYP450 affinity'
      },
      {
        'question': 'Why take PPIs before meals?',
        'options': ['Better absorption', 'Activate in acid', 'Reduce nausea', 'Enhance bioavailability'],
        'correct': 1,
        'explanation': 'PPIs need acidic environment for activation'
      },
    ],
    'h2_blockers': [
      {
        'question': 'How do H2 blockers work?',
        'options': ['Inhibit proton pump', 'Block H2 receptors', 'Neutralize acid', 'Bind to ulcers'],
        'correct': 1,
        'explanation': 'H2 blockers competitively antagonize H2 receptors'
      },
    ],
    'antacids': [
      {
        'question': 'What is the main action of antacids?',
        'options': ['Block acid production', 'Neutralize existing acid', 'Inhibit proton pump', 'Bind to ulcers'],
        'correct': 1,
        'explanation': 'Antacids directly neutralize HCl in stomach'
      },
    ],
  };

  void _startQuiz() {
    setState(() {
      _questions = _quizData[_selectedTopic] ?? [];
      _currentQuestionIndex = 0;
      _selectedAnswer = null;
      _score = 0;
      _quizCompleted = false;
    });
  }

  void _submitAnswer() {
    if (_selectedAnswer == null) return;

    final currentQuestion = _questions[_currentQuestionIndex];
    if (int.parse(_selectedAnswer!) == currentQuestion['correct']) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
      });
    } else {
      setState(() {
        _quizCompleted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_quizCompleted) {
      return _buildResults();
    }

    if (_questions.isEmpty) {
      return _buildSetup();
    }

    return _buildQuiz();
  }

  Widget _buildSetup() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Quiz Topic & Difficulty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          DropdownButtonFormField<String>(
            value: _selectedTopic,
            decoration: const InputDecoration(labelText: 'Topic'),
            items: drugClasses.map((drugClass) => 
              DropdownMenuItem(value: drugClass['id'], child: Text(drugClass['name']))
            ).toList(),
            onChanged: (value) => setState(() => _selectedTopic = value!),
          ),
          
          DropdownButtonFormField<String>(
            value: _selectedDifficulty,
            decoration: const InputDecoration(labelText: 'Difficulty'),
            items: const [
              DropdownMenuItem(value: 'beginner', child: Text('Beginner')),
              DropdownMenuItem(value: 'intermediate', child: Text('Intermediate')),
              DropdownMenuItem(value: 'advanced', child: Text('Advanced')),
            ],
            onChanged: (value) => setState(() => _selectedDifficulty = value!),
          ),
          
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: _startQuiz,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Start Quiz'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuiz() {
    final question = _questions[_currentQuestionIndex];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question ${_currentQuestionIndex + 1}/${_questions.length}', 
                style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          Text(question['question'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          
          ...List.generate(question['options'].length, (index) => 
            RadioListTile<String>(
              title: Text(question['options'][index]),
              value: index.toString(),
              groupValue: _selectedAnswer,
              onChanged: (value) => setState(() => _selectedAnswer = value),
            )
          ),
          
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: _selectedAnswer != null ? _submitAnswer : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(_currentQuestionIndex == _questions.length - 1 ? 'Finish Quiz' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    final percentage = (_score / _questions.length * 100).round();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.quiz, size: 64, color: Colors.blue),
          const SizedBox(height: 16),
          Text('Quiz Completed!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text('Score: $_score/${_questions.length} ($percentage%)', 
                style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 24),
          Text(_getGradeText(percentage), style: const TextStyle(fontSize: 16, color: Colors.green)),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _questions = []),
                child: const Text('New Quiz'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/progress'),
                child: const Text('View Progress'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getGradeText(int percentage) {
    if (percentage >= 90) return 'Excellent! Outstanding performance!';
    if (percentage >= 80) return 'Great job! Well done!';
    if (percentage >= 70) return 'Good work! Keep studying!';
    if (percentage >= 60) return 'Not bad! Review weak areas!';
    return 'Keep practicing! Review the material!';
  }
}