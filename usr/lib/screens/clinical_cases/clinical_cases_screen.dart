import 'package:flutter/material.dart';
import '../../data/drug_data.dart';

class ClinicalCasesScreen extends StatelessWidget {
  const ClinicalCasesScreen({super.key});

  final List<Map<String, dynamic>> clinicalCases = const [
    {
      'title': 'GERD Patient with Persistent Heartburn',
      'scenario': '''A 45-year-old male presents with 6 months of daily heartburn, worse after meals and when lying down. Symptoms partially relieved by antacids. Endoscopy shows erosive esophagitis.''',
      'questions': [
        'What is your initial treatment choice?',
        'Why did you choose this medication?',
        'What monitoring is needed?',
        'What if symptoms persist?'
      ],
      'correct_drug': 'omeprazole',
      'explanation': '''PPI therapy (omeprazole 20-40mg daily) is first-line for erosive esophagitis. PPIs provide superior acid suppression compared to H2 blockers. Treatment duration is typically 4-8 weeks initially, with maintenance therapy if needed.''',
      'alternatives': ['esomeprazole', 'pantoprazole'],
      'monitoring': 'Symptom improvement, consider repeat endoscopy after 8 weeks if no response',
    },
    {
      'title': 'H. pylori Positive Peptic Ulcer',
      'scenario': '''A 35-year-old female with epigastric pain and nausea. Endoscopy reveals duodenal ulcer. H. pylori testing is positive.''',
      'questions': [
        'What treatment regimen would you prescribe?',
        'Why include these specific medications?',
        'How long is treatment duration?',
        'What if the patient has penicillin allergy?'
      ],
      'correct_drug': 'triple_therapy',
      'explanation': '''Triple therapy: PPI (omeprazole) + amoxicillin + clarithromycin for 14 days. This eradicates H. pylori in 80-90% of cases. PPI suppresses acid to allow antibiotics to work in stomach environment.''',
      'alternatives': ['bismuth_quadruple_therapy'],
      'monitoring': 'Test for H. pylori eradication 4 weeks after completing antibiotics',
    },
    {
      'title': 'NSAID-Induced Ulcer Prophylaxis',
      'scenario': '''A 60-year-old female with osteoarthritis requires chronic NSAID therapy (ibuprofen 800mg TID). She has no GI symptoms but has history of uncomplicated ulcer.''',
      'questions': [
        'Would you prescribe prophylactic therapy?',
        'Which medication and why?',
        'When would you choose a different approach?'
      ],
      'correct_drug': 'misoprostol',
      'explanation': '''Misoprostol 200mcg BID is indicated for NSAID ulcer prophylaxis. It replaces protective prostaglandins depleted by NSAIDs. Alternative: PPI therapy if misoprostol side effects (diarrhea) are intolerable.''',
      'alternatives': ['omeprazole', 'lansoprazole'],
      'monitoring': 'GI symptoms, consider discontinuation if NSAIDs stopped',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏥 Clinical Cases'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: clinicalCases.length,
        itemBuilder: (context, index) {
          final caseData = clinicalCases[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              title: Text(
                caseData['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(caseData['scenario'].substring(0, 100) + '...'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📋 Case Scenario:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(caseData['scenario']),
                      const SizedBox(height: 16),
                      const Text(
                        '❓ Questions to Consider:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...caseData['questions'].map<Widget>((question) => 
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text('• $question'),
                        )
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '✅ Recommended Treatment:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(caseData['explanation']),
                          ],
                        ),
                      ),
                      if (caseData['alternatives'] != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '🔄 Alternative Options:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              ...caseData['alternatives'].map<Widget>((alt) => 
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: Text('• ${_getDrugName(alt)}'),
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '📊 Monitoring & Follow-up:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(caseData['monitoring']),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getDrugName(String drugId) {
    for (var drugClass in drugClasses) {
      for (var drug in drugClass['drugs']) {
        if (drug['id'] == drugId) {
          return drug['name'];
        }
      }
    }
    return drugId;
  }
}