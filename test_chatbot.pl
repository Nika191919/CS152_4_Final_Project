:- consult('chatbot.pl').

test_all :-
    test("i feel anxious", anxious),
    test("i feel tense", anxious),
    test("i'm sad", sad),
    test("i am upset", sad),
    test("feeling happy", happy),
    test("i am joyful", happy),
    test("i feel angry", angry),
    test("i'm furious", angry),
    test("i am shy", shy),
    test("i feel embarrassed", shy),
    test("i'm afraid", afraid),
    test("i feel dread", afraid),
    test("i'm annoyed", annoyed),
    test("i am frustrated", annoyed).

test(Input, ExpectedEmotion) :-
    writeln("-----"),
    format("Test input: ~w~n", [Input]),
    downcase_atom(Input, Lower),
    atomic_list_concat(Words, ' ', Lower),
    (
        member(W, Words),
        normalize_emotion(W, Detected),
        Detected = ExpectedEmotion ->
            format("✅ Recognized as: ~w~n", [Detected])
        ;
            format("❌ Failed to recognize emotion. Detected: ~w~n", [Detected])
    ).
