#!/usr/bin/env python3
import json

articles = []
tasks = []

article_topics = [
    ("Secrets of the Great Pyramid", "Unraveling the mysteries of Khufu's eternal monument", ["pyramids", "giza", "construction"], 15, False),
    ("The Curse of the Pharaohs", "Myth, mystery, and the truth behind Tutankhamun's tomb", ["tutankhamun", "curses", "mythology"], 12, False),
    ("Hieroglyphics: The Sacred Script", "Decoding the language of the gods", ["hieroglyphics", "language", "rosetta stone"], 14, False),
    ("Cleopatra: Last Pharaoh of Egypt", "The life and legacy of Egypt's final ruler", ["cleopatra", "ptolemaic", "rulers"], 13, False),
    ("Mummification: Preserving the Dead", "Ancient Egyptian techniques for eternal life", ["mummification", "death", "rituals"], 16, True),
    ("The Valley of the Kings", "Royal necropolis and its hidden treasures", ["valley of kings", "tombs", "excavation"], 14, False),
    ("Ancient Egyptian Gods and Goddesses", "The divine pantheon of the Nile", ["religion", "gods", "mythology"], 18, False),
    ("The Sphinx: Guardian of Giza", "Mysteries of the great limestone monument", ["sphinx", "giza", "monuments"], 11, False),
    ("Ramesses II: The Great Builder", "Legacy of Egypt's most powerful pharaoh", ["ramesses", "pharaohs", "monuments"], 15, True),
    ("The Nile: Lifeblood of Egypt", "How the river shaped civilization", ["nile", "geography", "agriculture"], 12, False),
    ("Ancient Egyptian Medicine", "Healing practices of the ancient world", ["medicine", "science", "health"], 13, False),
    ("The Book of the Dead", "Guide to the Egyptian afterlife", ["afterlife", "religion", "texts"], 17, True),
    ("Akhenaten's Religious Revolution", "The pharaoh who changed everything", ["akhenaten", "religion", "history"], 14, False),
    ("Ancient Egyptian Warfare", "Military tactics and conquests", ["warfare", "military", "history"], 13, False),
    ("The Rosetta Stone Discovery", "Key to unlocking ancient secrets", ["rosetta stone", "discovery", "language"], 12, False),
    ("Daily Life in Ancient Egypt", "How ordinary Egyptians lived", ["daily life", "society", "culture"], 15, False),
    ("The Pyramids of Dahshur", "Lesser-known but equally fascinating", ["pyramids", "dahshur", "architecture"], 11, True),
    ("Hatshepsut: The Female Pharaoh", "Egypt's most successful woman ruler", ["hatshepsut", "pharaohs", "women"], 14, False),
    ("Ancient Egyptian Art and Symbolism", "Understanding the visual language", ["art", "symbolism", "culture"], 16, True),
    ("The Lost City of Alexandria", "Ancient world's greatest library", ["alexandria", "library", "hellenistic"], 13, False)
]

task_topics = [
    ("Build the Great Pyramid", "Master ancient engineering techniques", "medium", False),
    ("Decode Hieroglyphics", "Learn to read ancient Egyptian writing", "easy", False),
    ("Mummify a Pharaoh", "Preserve a body for eternity", "hard", True),
    ("Navigate the Nile", "Journey through ancient Egypt's waterways", "easy", False),
    ("Construct a Temple", "Build a monument to the gods", "medium", False),
    ("Excavate a Tomb", "Uncover hidden treasures", "medium", True),
    ("Create a Cartouche", "Design your own royal name seal", "easy", False),
    ("Master Ancient Medicine", "Learn healing techniques of the ancients", "hard", True),
    ("Plan a Royal Funeral", "Organize a pharaoh's journey to the afterlife", "hard", False),
    ("Design a Sphinx", "Create your own guardian monument", "medium", False),
    ("Trade on the Nile", "Become a successful ancient merchant", "easy", False),
    ("Worship the Gods", "Perform ancient Egyptian rituals", "medium", True),
    ("Build a Mastaba", "Construct an early tomb structure", "easy", False),
    ("Decipher the Book of the Dead", "Understand the afterlife guide", "hard", True),
    ("Create Ancient Jewelry", "Craft royal adornments", "medium", False),
    ("Survey Land for Farming", "Use ancient measurement techniques", "easy", False),
    ("Prepare for the Afterlife", "Complete your journey preparations", "medium", True),
    ("Carve a Statue", "Create monumental sculpture", "hard", False),
    ("Organize a Festival", "Celebrate the gods in ancient style", "medium", False),
    ("Explore the Western Desert", "Journey into the unknown", "hard", True)
]

for i, (title, subtitle, tags, read_time, premium) in enumerate(article_topics, 1):
    article = {
        "id": f"article_{i:03d}",
        "title": title,
        "subtitle": subtitle,
        "coverImage": f"cover_{i}",
        "estimatedReadTime": read_time,
        "isPremium": premium,
        "tags": tags,
        "sections": [
            {
                "id": f"sec_{i:03d}_1",
                "title": "Historical Background",
                "content": f"This section explores the historical context of {title.lower()}, examining the archaeological evidence and scholarly research that has shaped our understanding. Ancient Egyptian civilization developed along the Nile River over thousands of years, creating one of the world's most enduring and influential cultures. The evidence we have today comes from a combination of archaeological excavations, ancient texts, and modern scientific analysis. Researchers continue to make new discoveries that challenge and refine our understanding of this fascinating period in human history."
            },
            {
                "id": f"sec_{i:03d}_2",
                "title": "Detailed Analysis",
                "content": f"A deeper examination of {title.lower()} reveals the complexity and sophistication of ancient Egyptian society. The Egyptians developed advanced techniques in architecture, medicine, mathematics, and administration that were far ahead of their time. Their religious beliefs permeated every aspect of life, from the grandest royal monuments to the humblest daily activities. The integration of practical knowledge with spiritual understanding created a unique worldview that sustained their civilization for over three millennia. Modern scholars use interdisciplinary approaches combining archaeology, linguistics, chemistry, and other sciences to piece together the full picture."
            },
            {
                "id": f"sec_{i:03d}_3",
                "title": "Modern Perspectives",
                "content": f"Contemporary research on {title.lower()} continues to yield fascinating insights and occasionally overturns long-held assumptions. New technologies like satellite imagery, DNA analysis, and advanced dating methods are revolutionizing our understanding of ancient Egypt. International teams of researchers collaborate to preserve and study Egypt's cultural heritage while respecting the significance of these sites to modern Egyptians. The lessons we learn from studying ancient Egyptian civilization remain relevant today, offering insights into sustainable agriculture, effective governance, artistic expression, and the human quest for meaning and immortality."
            }
        ]
    }
    articles.append(article)

step_templates = [
    ("Understanding the Basics", "Learn the fundamental concepts and historical context necessary for this quest. Ancient Egyptians possessed knowledge that was passed down through generations of skilled craftsmen and priests."),
    ("Gathering Resources", "Collect the materials, tools, and knowledge required to proceed. The ancient Egyptians were masters of resource management and logistics."),
    ("Preparing the Foundation", "Establish the groundwork for your project with careful planning and measurement. Precision was paramount in ancient Egyptian construction and craftsmanship."),
    ("Executing the Main Work", "Carry out the primary tasks using authentic ancient techniques. This step requires patience, skill, and attention to detail."),
    ("Adding Finishing Touches", "Complete the finer details that distinguish masterwork from ordinary work. The Egyptians believed that perfection honored the gods."),
    ("Final Completion", "Review your work and perform any final rituals or ceremonies. Ancient Egyptians marked completion with religious observances and celebrations.")
]

for i, (title, subtitle, difficulty, premium) in enumerate(task_topics, 1):
    steps = []
    for j, (step_title, step_desc) in enumerate(step_templates, 1):
        steps.append({
            "id": f"step_{i:03d}_{j}",
            "step": j,
            "title": step_title,
            "description": f"{step_desc} In the context of {title.lower()}, this involves understanding the specific techniques and knowledge that ancient Egyptians would have employed. Archaeological evidence and ancient texts provide guidance on the methods used."
        })
    
    task = {
        "id": f"task_{i:03d}",
        "title": title,
        "subtitle": subtitle,
        "coverImage": f"task_cover_{i}",
        "difficulty": difficulty,
        "isPremium": premium,
        "steps": steps
    }
    tasks.append(task)

with open('Spikings/Resources/Data/articles_sk.json', 'w') as f:
    json.dump(articles, f, indent=2)

with open('Spikings/Resources/Data/tasks_sk.json', 'w') as f:
    json.dump(tasks, f, indent=2)

print(f"Generated {len(articles)} articles and {len(tasks)} tasks")
