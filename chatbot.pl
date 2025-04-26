% === Emotion-Based Chatbot with DCG and Synonym Recognition ===

% --- Core Emotion Responses ---
respond(anxious, "Take a deep breath and drink a glass of water. Write down what is making you anxious. If there is something you can do about it now, take action—it will help you feel more in control. If it is out of your hands, let it go, say a prayer if you would like, and trust things will work out.").

respond(sad, "Ask yourself: What made you feel this way? Was it something you did or something outside your control? If it was you, acknowledge it, learn from it, and promise yourself to do better. If it was external, remember you can’t control everything—but you can choose how to respond. Keep moving forward.").

respond(happy, "Take a moment to slow down and feel the joy. Express gratitude, share the moment if you can, and use this energy to keep growing and doing good.").

respond(angry, "What exactly are you angry about—and why? Can you do something to change it? If yes, take that step. If not, let it out in a healthy way: go for a walk, listen to music, or write it down. Don’t let anger sit in your chest.").

respond(shy, "Most people are focused on themselves, not on you. Let that free you. This is your one life—don’t miss out. Take small steps, one at a time. Be brave, even if your voice shakes. You’re doing it for you.").

respond(afraid, "Ask yourself: What exactly are you afraid of? Who or what is triggering it? What is one small thing you can do right now? Action reduces fear—take one small step forward.").

respond(annoyed, "Pause. Drink a glass of water. Write down what is bothering you. Can you fix it right now? If yes, do it. If not, don’t let it ruin your peace—pray, let it go, or distract yourself with something calming.").

% --- Synonym Mapping ---
map_synonym(worried, anxious).
map_synonym(nervous, anxious).
map_synonym(uneasy, anxious).
map_synonym(apprehensive, anxious).
map_synonym(tense, anxious).

map_synonym(down, sad).
map_synonym(upset, sad).
map_synonym(disappointed, sad).
map_synonym(sorrowful, sad).
map_synonym(gloomy, sad).
map_synonym(downcast, sad).
map_synonym(depressed, sad).

map_synonym(joyful, happy).
map_synonym(cheerful, happy).
map_synonym(content, happy).
map_synonym(delighted, happy).
map_synonym(elated, happy).

map_synonym(mad, angry).
map_synonym(furious, angry).
map_synonym(resentful, angry).
map_synonym(irate, angry).
map_synonym(enraged, angry).

map_synonym(ashamed, shy).
map_synonym(embarrassed, shy).
map_synonym(reserved, shy).
map_synonym(hesitant, shy).

map_synonym(fear, afraid).
map_synonym(dread, afraid).
map_synonym(panic, afraid).
map_synonym(apprehension, afraid).
map_synonym(fright, afraid).

map_synonym(irritated, annoyed).
map_synonym(frustrated, annoyed).
map_synonym(bothered, annoyed).
map_synonym(aggravated, annoyed).
map_synonym(exasperated, annoyed).

% --- DCG Grammar for Base Emotions ---
sentence(Emotion) --> emotion_phrase(Emotion).

emotion_phrase(Emotion) --> [i, feel], emotion_word(Emotion).
emotion_phrase(Emotion) --> [i, am], emotion_word(Emotion).
emotion_phrase(Emotion) --> ["i'm"], emotion_word(Emotion).
emotion_phrase(Emotion) --> [feeling], emotion_word(Emotion).

emotion_word(anxious) --> [anxious].
emotion_word(sad) --> [sad].
emotion_word(happy) --> [happy].
emotion_word(angry) --> [angry].
emotion_word(shy) --> [shy].
emotion_word(afraid) --> [afraid].
emotion_word(annoyed) --> [annoyed].

% --- Normalize Word to Core Emotion ---
normalize_emotion(Word, Emotion) :-
    map_synonym(Word, Emotion), !.
normalize_emotion(Word, Word).

% --- Main Chat Loop ---
chat :-
    writeln("Emotion Chatbot (type 'bye' to quit)"),
    repeat,
    write('User: '),
    read_line_to_string(user_input, Input),
    downcase_atom(Input, LowercaseInput),
    atom_chars(LowercaseInput, Chars),
    exclude(is_punct, Chars, CleanChars),
    atom_chars(CleanAtom, CleanChars),  % <== CONVERT BACK to atom
    atomic_list_concat(Words, ' ', CleanAtom),
    (
        member(bye, Words) ->
            writeln("Bot: Goodbye! Take care."), !;
        (
            member(W, Words),
            normalize_emotion(W, Emotion),
            respond(Emotion, Response) ->
                format("Bot: ~w~n", [Response])
            ;
            writeln("Bot: I'm not sure how to respond. Can you rephrase?")
        )
    ),
    fail.

is_punct(Char) :-
    member(Char, ['.', ',', '!', '?', ';', ':']).
