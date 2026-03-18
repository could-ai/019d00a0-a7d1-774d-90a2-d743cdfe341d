const List<Map<String, dynamic>> drugClasses = [
  {
    "id": "antimicrobial_gi",
    "name": "Antimicrobial Agents (GI)",
    "use": "H. pylori eradication",
    "drugs": [
      {
        "id": "amoxicillin",
        "name": "Amoxicillin",
        "class": "Beta-lactam antibiotic",
        "mechanism": "Inhibits bacterial cell wall synthesis by binding to PBPs (Penicillin Binding Proteins). Causes osmotic lysis of bacteria.",
        "pharmacokinetics": {
          "onset": "30-60 minutes",
          "duration": "6-8 hours",
        },
        "clinical_use": ["H. pylori triple therapy", "GI infections"],
        "benefits": ["Kills H. pylori", "Prevents ulcer recurrence", "Well tolerated"],
        "side_effects": ["Diarrhea", "Nausea", "Allergic reaction", "Rash", "Antibiotic-associated colitis"],
        "key_exam_fact": "Part of H. pylori TRIPLE THERAPY: Amoxicillin + Clarithromycin + PPI"
      },
      {
        "id": "bismuth_compounds",
        "name": "Bismuth Compounds",
        "class": "Heavy metal compound / Mucosal protective + Antimicrobial",
        "mechanism": "Disrupts bacterial cell membrane and inhibits urease enzyme of H. pylori. Also forms protective coating on ulcers.",
        "pharmacokinetics": {
          "onset": "Unknown",
          "duration": "Unknown",
        },
        "clinical_use": ["H. pylori quadruple therapy", "Traveler's diarrhea"],
        "benefits": ["Coats ulcer base", "Inhibits H. pylori urease"],
        "side_effects": ["Black tongue", "Black stool", "Constipation"],
        "key_exam_fact": "Bismuth causes BLACK STOOL — not blood — educate patient!"
      }
    ]
  },
  {
    "id": "h2_blockers",
    "name": "H2 Histamine Receptor Blockers",
    "use": "Reduce gastric acid secretion",
    "drugs": [
      {
        "id": "famotidine",
        "name": "Famotidine",
        "class": "H2 Blocker",
        "mechanism": "Selective competitive antagonist of H2 receptors on parietal cells",
        "pharmacokinetics": {
          "onset": "1-3 hours",
          "duration": "10-12 hours",
        },
        "clinical_use": ["GERD", "Peptic ulcer disease"],
        "benefits": ["No CYP450 inhibition", "Most potent H2 blocker"],
        "side_effects": ["Headache", "Dizziness", "Constipation or diarrhea"],
        "key_exam_fact": "FAMOTIDINE = Most potent H2 blocker with FEWEST drug interactions"
      },
      {
        "id": "cimetidine",
        "name": "Cimetidine",
        "class": "H2 Blocker",
        "mechanism": "Selective competitive antagonist of H2 receptors on parietal cells",
        "pharmacokinetics": {
          "onset": "1-2 hours",
          "duration": "4-5 hours",
        },
        "clinical_use": ["GERD", "Peptic ulcer disease"],
        "benefits": ["Reduces acid secretion"],
        "side_effects": ["Gynecomastia", "Impotence", "CYP450 inhibition"],
        "key_exam_fact": "CIMETIDINE = CYP450 inhibitor + Gynecomastia — most side effects among H2 blockers"
      }
    ]
  },
  {
    "id": "ppis",
    "name": "Proton Pump Inhibitors",
    "use": "Most powerful acid suppression",
    "drugs": [
      {
        "id": "omeprazole",
        "name": "Omeprazole",
        "class": "Proton Pump Inhibitor",
        "mechanism": "Irreversibly binds to H+/K+ ATPase (proton pump) — PERMANENTLY disable the pump",
        "pharmacokinetics": {
          "onset": "1 hour",
          "duration": "24-48 hours",
        },
        "clinical_use": ["GERD", "Peptic ulcer disease", "H. pylori eradication"],
        "benefits": ["Most effective acid suppression"],
        "side_effects": ["B12 deficiency", "Mg deficiency", "C. diff risk", "bone fractures"],
        "key_exam_fact": "FIRST PPI ever developed. Metabolized by CYP2C19 — poor metabolizers have higher drug levels"
      },
      {
        "id": "pantoprazole",
        "name": "Pantoprazole",
        "class": "Proton Pump Inhibitor",
        "mechanism": "Irreversibly binds to H+/K+ ATPase (proton pump)",
        "pharmacokinetics": {
          "onset": "2.5 hours",
          "duration": "24 hours",
        },
        "clinical_use": ["GERD", "Peptic ulcer disease"],
        "benefits": ["FEWEST drug interactions among all PPIs"],
        "side_effects": ["Headache", "Diarrhea"],
        "key_exam_fact": "PANTOPRAZOLE = Safest PPI for patients on multiple medications"
      }
    ]
  },
  {
    "id": "antacids",
    "name": "Antacids",
    "use": "Immediate neutralization of gastric acid",
    "drugs": [
      {
        "id": "magnesium_hydroxide",
        "name": "Magnesium Hydroxide",
        "class": "Antacid",
        "mechanism": "Direct chemical neutralization of HCl already in stomach",
        "pharmacokinetics": {
          "onset": "Fast — within 5 minutes",
          "duration": "Short",
        },
        "clinical_use": ["Heartburn", "Indigestion"],
        "benefits": ["Immediate relief"],
        "side_effects": ["DIARRHEA (laxative effect)"],
        "key_exam_fact": "Mg antacids = DIARRHEA. Combined with Al antacids to balance effects."
      },
      {
        "id": "calcium_carbonate",
        "name": "Calcium Carbonate",
        "class": "Antacid",
        "mechanism": "Direct chemical neutralization of HCl already in stomach",
        "pharmacokinetics": {
          "onset": "Fast",
          "duration": "Short",
        },
        "clinical_use": ["Heartburn", "Indigestion", "Calcium supplementation"],
        "benefits": ["Immediate relief"],
        "side_effects": ["ACID REBOUND", "Belching", "Constipation"],
        "key_exam_fact": "Calcium carbonate = ACID REBOUND effect + CO2 causes belching"
      }
    ]
  }
];
