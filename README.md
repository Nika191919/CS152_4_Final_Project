# CS152_4_Final_Project
# Emotion-Response Chatbot — CS152 Final Project

This project is a symbolic AI chatbot built using **Prolog**, designed to recognize emotional cues from user input and respond with supportive, empathy-based messages. The chatbot parses natural language phrases using grammar rules and intelligently maps a wide range of emotion-related words to a set of core emotional states.

---

## 🧠 Targeted Learning Outcomes

- `#cs152-ailogic`: The chatbot uses logic programming (DCG and predicate logic) to represent knowledge and perform inference about emotional language.
- `#cs152-aicoding`: The project demonstrates effective implementation of a symbolic AI system in Prolog, with grammar parsing and response generation.

---

## 💡 Features

- Recognizes core emotions: `anxious`, `sad`, `happy`, `angry`, `shy`, `afraid`, `annoyed`
- Understands **synonyms** of these emotions (e.g. “tense”, “furious”, “frustrated”) via a synonym mapping system
- Parses natural phrases like “I feel sad”, “I’m anxious”, or “I am frustrated” using **Definite Clause Grammars (DCG)**
- Provides unique, detailed responses tailored to each emotion
- Includes automated test script (`test_chatbot.pl`) to verify emotion recognition

---

## 🚀 How to Run

### 🖥️ In SWI-Prolog

1. Install [SWI-Prolog](https://www.swi-prolog.org/)
2. Clone this repo or download the `.pl` files

```bash
swipl
?- consult('chatbot.pl').
?- chat.
