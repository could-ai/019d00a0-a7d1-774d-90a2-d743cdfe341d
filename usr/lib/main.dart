import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/chat/chat_professor_screen.dart';
import 'screens/drug_library/drug_library_screen.dart';
import 'screens/quiz/quiz_screen.dart';
import 'screens/flashcards/flashcards_screen.dart';
import 'screens/notes_scanner/notes_scanner_screen.dart';
import 'screens/progress/progress_dashboard_screen.dart';
import 'screens/compare/compare_drugs_screen.dart';
import 'providers/app_provider.dart';
import 'data/drug_data.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const MedPharmAI(),
    ),
  );
}

class MedPharmAI extends StatelessWidget {
  const MedPharmAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedPharm AI - Pharmacology Professor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF0F8FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E3A8A),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF1E3A8A),
          unselectedItemColor: Colors.grey,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/chat': (context) => const ChatProfessorScreen(),
        '/drugs': (context) => const DrugLibraryScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/flashcards': (context) => const FlashcardsScreen(),
        '/scanner': (context) => const NotesScannerScreen(),
        '/progress': (context) => const ProgressDashboardScreen(),
        '/compare': (context) => const CompareDrugsScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ChatProfessorScreen(),
    DrugLibraryScreen(),
    QuizScreen(),
    FlashcardsScreen(),
    NotesScannerScreen(),
    ProgressDashboardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏥 MedPharm AI'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'AI Professor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            label: 'Drug Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: 'Flashcards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scan Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      persistentFooterButtons: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '⚠️ Educational Use Only - Not Medical Advice',
            style: TextStyle(fontSize: 10, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}