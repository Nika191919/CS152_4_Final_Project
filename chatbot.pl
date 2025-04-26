% === Emotion Chatbot with DCG & Synonym Mapping ===

% --- Core Emotion Responses ---
respond(anxious, 
  "Take a deep breath and drink a glass of water. Write down what's making you anxious. \
If you can do something about it now, take action - it will help you feel more in control. \
If it's out of your hands, let it go and trust things will work out.").

respond(sad,
  "Ask yourself: What made you feel this way? Was it something you did or something \
outside your control? If it was you, accept it, learn from it, and promise yourself to do \
better. If it was external, remember you can't control everything - but you can choose \
how to respond. Keep moving forward.").

respond(happy,
  "Take a moment to slow down and feel the joy. Express gratitude, share the moment if \
you can, and use this energy to keep growing and doing good.").

respond(angry,
  "What are you angry about and why? Can you do something to change it? If yes, take that \
step. If not, let it out in a healthy way: go for a walk, listen to music, or write it down. \
Don't let anger sit in your chest.").

respond(shy,
  "Most people are focused on themselves, not on you. Let that free you. This is your one \
life - don't miss out. Take small steps, one at a time. Be brave even if your voice shakes.").

respond(afraid,
  "Ask yourself: What are you afraid of? Who or what is triggering it? What's one small \
thing you can do right now? Action reduces fear - take a small step forward.").

respond(annoyed,
  "Pause and drink a glass of water. Write down what's bothering you. Can you fix it right \
now? If yes, do it. If not, let it go and distract yourself with something calming.").

% --- Synonym Mapping ---
map_synonym(nervous,   anxious).
map_synonym(worried,   anxious).
map_synonym(uneasy,    anxious).
map_synonym(apprehensive, anxious).
map_synonym(tense,     anxious).

map_synonym(down,      sad).
map_synonym(upset,     sad).
map_synonym(disappointed, sad).
map_synonym(sorrowful, sad).
map_synonym(gloomy,    sad).
map_synonym(downcast,  sad).
map_synonym(depressed, sad).

map_synonym(joyful,    happy).
map_synonym(cheerful,  happy).
map_synonym(content,   happy).
map_synonym(delighted, happy).
map_synonym(elated,    happy).

map_synonym(mad,       angry).
map_synonym(furious,   angry).
map_synonym(irate,     angry).
map_synonym(enraged,   angry).
map_synonym(resentful, angry).

map_synonym(ashamed,   shy).
map_synonym(embarrassed, shy).
map_synonym(reserved,  shy).
map_synonym(hesitant,  shy).

map_synonym(fear,      afraid).
map_synonym(dread,     afraid).
map_synonym(panic,     afraid).
map_synonym(apprehension, afraid).
map_synonym(fright,    afraid).

map_synonym(irritated, annoyed).
map_synonym(frustrated, annoyed).
map_synonym(bothered,  annoyed).
map_synonym(aggravated, annoyed).
map_synonym(exasperated, annoyed).

% --- Normalize to Core Emotion ---
normalize_emotion(W, E) :- 
    map_synonym(W, E), !.
normalize_emotion(W, W).

% --- DCG for "I feel X" ---
sentence(Emotion) --> i_feel, emotion_word(Emotion).

i_feel --> [i, feel].
i_feel --> [i, am].
i_feel --> [feeling].

emotion_word(anxious)  --> [anxious].
emotion_word(sad)      --> [sad].
emotion_word(happy)    --> [happy].
emotion_word(angry)    --> [angry].
emotion_word(shy)      --> [shy].
emotion_word(afraid)   --> [afraid].
emotion_word(annoyed)  --> [annoyed].

% --- Main Chat Loop ---
chat :-
    writeln("Emotion Chatbot (type bye to quit)"),
    repeat,
      write("You: "), flush_output,
      read_line_to_string(user_input, Input),
      downcase_atom(Input, Lower),
      ( Lower = "bye" ->
          writeln("Bot: Goodbye!"), !
      ;
          atomic_list_concat(Words, ' ', Lower),
          ( phrase(sentence(Em), Words) ->
                respond(Em, R), format("Bot: ~w~n", [R])
          ; findall(E2,
                ( member(W2, Words),
                  normalize_emotion(W2, E2),
                  respond(E2, _) ),
                Matched),
            ( Matched = [] ->
                writeln("Bot: I'm not sure how to respond. Can you rephrase?")
            ; reply_emotions(Matched)
            )
          ),
          fail
      ).

reply_emotions([]).
reply_emotions([E|Es]) :-
    respond(E, R2),
    format("Bot: ~w~n", [R2]),
    reply_emotions(Es).

% --- Helper to strip punctuation ---
is_punct(C) :- member(C, ['.', ',', '!', '?', ';', ':']).
