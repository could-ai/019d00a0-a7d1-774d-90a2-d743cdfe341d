import 'package:flutter/material.dart';
import '../../data/drug_data.dart';

class DrugLibraryScreen extends StatefulWidget {
  const DrugLibraryScreen({super.key});

  @override
  State<DrugLibraryScreen> createState() => _DrugLibraryScreenState();
}

class _DrugLibraryScreenState extends State<DrugLibraryScreen> {
  String _searchQuery = '';
  String _selectedClass = 'All';

  List<Map<String, dynamic>> get filteredDrugs {
    List<Map<String, dynamic>> allDrugs = [];
    
    for (var drugClass in drugClasses) {
      for (var drug in drugClass['drugs']) {
        allDrugs.add({
          ...drug,
          'class_name': drugClass['name'],
          'class_id': drugClass['id'],
        });
      }
    }

    return allDrugs.where((drug) {
      final matchesSearch = drug['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                          drug['class_name'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesClass = _selectedClass == 'All' || drug['class_id'] == _selectedClass;
      return matchesSearch && matchesClass;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: const InputDecoration(
                    hintText: 'Search drugs or classes...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: _selectedClass == 'All',
                        onSelected: (selected) => setState(() => _selectedClass = 'All'),
                      ),
                      ...drugClasses.map((drugClass) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: FilterChip(
                          label: Text(drugClass['name']),
                          selected: _selectedClass == drugClass['id'],
                          onSelected: (selected) => setState(() => 
                            _selectedClass = selected ? drugClass['id'] : 'All'),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Drug List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredDrugs.length,
              itemBuilder: (context, index) {
                final drug = filteredDrugs[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getClassColor(drug['class_id']),
                      child: Text(
                        drug['name'][0].toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(drug['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(drug['class_name']),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => _showDrugDetail(context, drug),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getClassColor(String classId) {
    const colors = {
      'antimicrobial_gi': Colors.blue,
      'h2_blockers': Colors.green,
      'ppis': Colors.orange,
      'antacids': Colors.purple,
      'mucosal_protective': Colors.teal,
      'prostaglandins': Colors.pink,
      'antimuscarinic': Colors.indigo,
    };
    return colors[classId] ?? Colors.grey;
  }

  void _showDrugDetail(BuildContext context, Map<String, dynamic> drug) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(drug['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Class: ${drug['class']}', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              
              _buildSection('Mechanism of Action', drug['mechanism']),
              _buildSection('Clinical Uses', drug['clinical_use']?.join(', ')),
              _buildSection('Benefits', drug['benefits']?.join(', ')),
              _buildSection('Side Effects', drug['side_effects']?.join(', ')),
              _buildSection('Key Exam Fact', drug['key_exam_fact']),
              
              if (drug['brand_names'] != null)
                _buildSection('Brand Names', drug['brand_names'].join(', ')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String? content) {
    if (content == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
        const SizedBox(height: 4),
        Text(content),
        const SizedBox(height: 12),
      ],
    );
  }
}