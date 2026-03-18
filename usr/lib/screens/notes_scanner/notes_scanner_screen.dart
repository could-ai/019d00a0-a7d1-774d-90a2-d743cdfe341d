import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../providers/app_provider.dart';

class NotesScannerScreen extends StatefulWidget {
  const NotesScannerScreen({super.key});

  @override
  State<NotesScannerScreen> createState() => _NotesScannerScreenState();
}

class _NotesScannerScreenState extends State<NotesScannerScreen> {
  File? _image;
  String _scannedText = '';
  bool _isProcessing = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isProcessing = true;
      });
      
      // Simulate OCR processing
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock OCR result - in real app this would use Claude Vision
      _processImage();
    }
  }

  void _processImage() {
    // Mock OCR result based on the AGENT.md specification
    setState(() {
      _scannedText = '''## 📝 Notes Analysis Complete

**Drugs Found in Your Notes:**
- Omeprazole (PPI)
- Famotidine (H2 Blocker)
- Calcium Carbonate (Antacid)
- Amoxicillin (Antibiotic)

---

## 💊 Detailed Explanations

### Omeprazole
**Mechanism:** Irreversibly inhibits H+/K+ ATPase (proton pump) in parietal cells
**Key Fact:** First PPI developed, prodrug requiring acidic activation

### Famotidine  
**Mechanism:** Competitive H2 receptor antagonist
**Key Fact:** Most potent H2 blocker with fewest drug interactions

### Calcium Carbonate
**Mechanism:** Directly neutralizes gastric HCl
**Key Fact:** Can cause acid rebound if overused

### Amoxicillin
**Mechanism:** Beta-lactam antibiotic inhibiting cell wall synthesis
**Key Fact:** Part of H. pylori triple therapy regimen

---

## 🧠 Generated Quiz Questions

**Q1:** Which drug irreversibly inhibits the proton pump?
A) Famotidine  B) Omeprazole  C) Calcium Carbonate  D) Amoxicillin
**Answer: B** - PPIs like omeprazole permanently disable the proton pump

**Q2:** What is the main advantage of Famotidine over Cimetidine?
A) Faster onset  B) Fewer drug interactions  C) Lower cost  D) IV formulation
**Answer: B** - Famotidine has minimal CYP450 inhibition

**Q3:** Which antibiotic is commonly used in H. pylori treatment?
A) Omeprazole  B) Famotidine  C) Calcium Carbonate  D) Amoxicillin
**Answer: D** - Amoxicillin is a key component of triple therapy

---

## 📚 Study Recommendations
Based on your notes, focus on:
- PPI mechanisms and clinical uses
- H2 blocker differences and interactions
- H. pylori treatment regimens
- Antacid limitations and side effects

💡 **Pro Tip:** PPIs are prodrugs - they need stomach acid to work!'''.trim();
      _isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              '📷 Scan Your Pharmacology Notes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Upload a photo of your handwritten notes and get instant explanations, flashcards, and quiz questions!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            
            // Image preview
            if (_image != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(_image!, fit: BoxFit.cover),
                ),
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, style: BorderStyle.dashed),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text('No image selected', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            
            const SizedBox(height: 24),
            
            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Take Photo'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('From Gallery'),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Processing indicator
            if (_isProcessing)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Analyzing your notes...'),
                ],
              ),
            
            // Results
            if (_scannedText.isNotEmpty)
              Container(
                width: double.infinity,
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
                      '📋 Analysis Results',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(_scannedText),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}