import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  // Mock AI responses for demonstration
  String mockAIResponse(String message) {
    if (message.toLowerCase().contains('omeprazole') || message.toLowerCase().contains('ppi')) {
      return '''## Omeprazole (Proton Pump Inhibitor)

**Drug Class:** Proton Pump Inhibitor (PPI)

**Mechanism of Action:**
Omeprazole is a prodrug that gets activated in the acidic environment of the parietal cell canaliculus. It irreversibly binds to the H+/K+ ATPase (proton pump) enzyme, permanently disabling it from pumping hydrogen ions into the stomach lumen.

**Body Pathway Step by Step:**
1. **Absorption:** Taken orally, absorbed in small intestine
2. **Activation:** Converted to sulfenamide in acidic environment (pH < 5)
3. **Target:** H+/K+ ATPase on parietal cell membrane
4. **Action:** Covalent binding permanently inhibits proton pump
5. **Result:** 90-95% reduction in acid secretion for 24-48 hours

**Pharmacokinetics:**
- **Onset:** 1 hour
- **Peak:** 2 hours  
- **Duration:** 24-48 hours
- **Metabolism:** CYP2C19 (genetic variations affect response)
- **Half-life:** 30-60 minutes

**Clinical Uses:**
- GERD (Gastroesophageal Reflux Disease)
- Peptic ulcer disease
- H. pylori eradication (triple therapy)
- Zollinger-Ellison syndrome

**Benefits:**
- Most effective acid suppression
- Healing of ulcers and erosions
- Prevention of NSAID-induced ulcers

**Side Effects:**
- Headache
- Diarrhea
- Abdominal pain
- Vitamin B12 deficiency (long-term)
- Increased risk of C. difficile infection

**Contraindications:**
- Hypersensitivity to PPIs
- Use with rilpivirine or atazanavir (reduces absorption)

**Drug Interactions:**
- Clopidogrel (reduces antiplatelet effect)
- Methotrexate (increased toxicity)
- CYP2C19 substrates (increased levels)

**Brand Names:** Prilosec, Losec

**Key Exam Fact:** First PPI developed. CYP2C19 poor metabolizers have higher drug levels and better response.

💡 **KEY EXAM TIP:** PPIs are prodrugs - they need ACIDIC environment to activate!'''.trim();
    }
    
    if (message.toLowerCase().contains('quiz')) {
      return '''Here are 5 MCQ questions on Proton Pump Inhibitors:

**Q1:** What is the mechanism of action of PPIs?
A) Block H2 receptors on parietal cells
B) Directly neutralize stomach acid
C) Irreversibly inhibit H+/K+ ATPase
D) Stimulate bicarbonate secretion
**ANSWER: C**
**EXPLANATION:** PPIs like omeprazole irreversibly bind to and inhibit the proton pump (H+/K+ ATPase), preventing acid secretion.

**Q2:** Why must PPIs be taken 30-60 minutes before meals?
A) To avoid food interference with absorption
B) To allow activation in acidic environment
C) To prevent nausea
D) To enhance bioavailability
**ANSWER: B**
**EXPLANATION:** PPIs are prodrugs that require acidic pH (<5) for activation in the parietal cell canaliculus.

**Q3:** Which PPI has the fewest drug interactions?
A) Omeprazole
B) Esomeprazole
C) Pantoprazole
D) Lansoprazole
**ANSWER: C**
**EXPLANATION:** Pantoprazole has the lowest affinity for CYP450 enzymes, resulting in fewer drug interactions.

**Q4:** What is a serious long-term side effect of PPI use?
A) Increased risk of pneumonia
B) Vitamin B12 deficiency
C) Hair loss
D) Kidney stones
**ANSWER: B**
**EXPLANATION:** Chronic PPI use can lead to vitamin B12 deficiency due to reduced absorption in the acidic environment needed for B12 uptake.

**Q5:** Which condition is NOT typically treated with PPIs?
A) GERD
B) Zollinger-Ellison syndrome
C) Acute gastritis
D) Traveler\'s diarrhea
**ANSWER: D**
**EXPLANATION:** Traveler\'s diarrhea is typically treated with bismuth subsalicylate (Pepto-Bismol) or antibiotics, not PPIs.

**Score:** Answer all questions above to see your score!
**Weak Areas to Review:** Focus on PPI mechanisms and long-term effects.'''.trim();
    }
    
    return '''Hello! I'm your MedPharm AI Professor, specialized in gastrointestinal and antiemetic pharmacology. 

I can help you understand:
• Drug mechanisms and body pathways
• Clinical uses and side effects
• Generate quizzes and flashcards
• Compare different drugs
• Explain handwritten notes (upload images)

What would you like to study today? Try asking about 