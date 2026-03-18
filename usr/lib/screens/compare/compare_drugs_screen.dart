import 'package:flutter/material.dart';
import '../../data/drug_data.dart';

class CompareDrugsScreen extends StatefulWidget {
  const CompareDrugsScreen({super.key});

  @override
  State<CompareDrugsScreen> createState() => _CompareDrugsScreenState();
}

class _CompareDrugsScreenState extends State<CompareDrugsScreen> {
  String? _drug1;
  String? _drug2;
  Map<String, dynamic>? _drug1Data;
  Map<String, dynamic>? _drug2Data;

  void _updateDrug1(String? drugId) {
    setState(() {
      _drug1 = drugId;
      _drug1Data = _findDrugById(drugId);
    });
  }

  void _updateDrug2(String? drugId) {
    setState(() {
      _drug2 = drugId;
      _drug2Data = _findDrugById(drugId);
    });
  }

  Map<String, dynamic>? _findDrugById(String? drugId) {
    if (drugId == null) return null;
    
    for (var drugClass in drugClasses) {
      for (var drug in drugClass['drugs']) {
        if (drug['id'] == drugId) {
          return {
            ...drug,
            'class_name': drugClass['name'],
          };
        }
      }
    }
    return null;
  }

  List<DropdownMenuItem<String>> _getAllDrugItems() {
    final items = <DropdownMenuItem<String>>[];
    
    for (var drugClass in drugClasses) {
      for (var drug in drugClass['drugs']) {
        items.add(DropdownMenuItem(
          value: drug['id'],
          child: Text('${drug['name']} (${drugClass['name']})'),
        ));
      }
    }
    
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '⚖️ Compare Drugs',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select two drugs to compare their mechanisms, uses, and characteristics',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            
            // Drug Selection
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('First Drug', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _drug1,
                        hint: const Text('Select drug'),
                        items: _getAllDrugItems(),
                        onChanged: _updateDrug1,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.compare_arrows, color: Colors.blue),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Second Drug', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _drug2,
                        hint: const Text('Select drug'),
                        items: _getAllDrugItems(),
                        onChanged: _updateDrug2,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Comparison Table
            if (_drug1Data != null && _drug2Data != null)
              _buildComparisonTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    final comparisons = [
      {'label': 'Drug Name', 'drug1': _drug1Data!['name'], 'drug2': _drug2Data!['name']},
      {'label': 'Class', 'drug1': _drug1Data!['class'], 'drug2': _drug2Data!['class']},
      {'label': 'Mechanism', 'drug1': _drug1Data!['mechanism'], 'drug2': _drug2Data!['mechanism']},
      {
        'label': 'Clinical Uses', 
        'drug1': (_drug1Data!['clinical_use'] as List<String>?)?.join(', ') ?? 'N/A',
        'drug2': (_drug2Data!['clinical_use'] as List<String>?)?.join(', ') ?? 'N/A'
      },
      {
        'label': 'Onset', 
        'drug1': _drug1Data!['pharmacokinetics']?['onset'] ?? 'N/A',
        'drug2': _drug2Data!['pharmacokinetics']?['onset'] ?? 'N/A'
      },
      {
        'label': 'Duration', 
        'drug1': _drug1Data!['pharmacokinetics']?['duration'] ?? 'N/A',
        'drug2': _drug2Data!['pharmacokinetics']?['duration'] ?? 'N/A'
      },
      {
        'label': 'Major Side Effects', 
        'drug1': (_drug1Data!['side_effects'] as List<String>?)?.join(', ') ?? 'N/A',
        'drug2': (_drug2Data!['side_effects'] as List<String>?)?.join(', ') ?? 'N/A'
      },
      {
        'label': 'Key Exam Fact', 
        'drug1': _drug1Data!['key_exam_fact'] ?? 'N/A',
        'drug2': _drug2Data!['key_exam_fact'] ?? 'N/A'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📊 Comparison Results',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
          },
          children: [
            // Header
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Aspect', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(_drug1Data!['name'], 
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(_drug2Data!['name'], 
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                ),
              ],
            ),
            // Data rows
            ...comparisons.map((comparison) => TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(comparison['label'], style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(comparison['drug1'], style: const TextStyle(fontSize: 12)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(comparison['drug2'], style: const TextStyle(fontSize: 12)),
                ),
              ],
            )),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '💡 Key Differences',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(_generateComparisonSummary()),
            ],
          ),
        ),
      ],
    );
  }

  String _generateComparisonSummary() {
    if (_drug1Data == null || _drug2Data == null) return '';
    
    final drug1 = _drug1Data!['name'];
    final drug2 = _drug2Data!['name'];
    final class1 = _drug1Data!['class'];
    final class2 = _drug2Data!['class'];
    
    String summary = '';
    
    if (class1 != class2) {
      summary += '• $drug1 is a $class1 while $drug2 is a $class2, so they work through different mechanisms.\n';
    }
    
    final onset1 = _drug1Data!['pharmacokinetics']?['onset'] ?? 'N/A';
    final onset2 = _drug2Data!['pharmacokinetics']?['onset'] ?? 'N/A';
    
    if (onset1 != 'N/A' && onset2 != 'N/A' && onset1 != onset2) {
      summary += '• $drug1 has ${onset1 == onset2 ? 'similar' : onset1.contains('minute') && onset2.contains('hour') ? 'faster' : 'slower'} onset compared to $drug2.\n';
    }
    
    summary += '• Consider the specific clinical scenario when choosing between these medications.\n';
    summary += '• Always check for contraindications and drug interactions before prescribing.';
    
    return summary;
  }
}