import pytest
import json
from build_sentences import (get_seven_letter_word, parse_json_from_file, choose_sentence_structure,
                              get_pronoun, get_article, get_word, fix_agreement, build_sentence, structures, pronouns,
    articles)

def test_get_seven_letter_word(mocker):
    mocker.patch("builtins.input", return_value="testingg")
    result = get_seven_letter_word()
    assert result == "TESTINGG"

def test_get_seven_letter_word_invalid(mocker):
    mocker.patch("builtins.input", return_value="short")
    with pytest.raises(ValueError):
        get_seven_letter_word()

def test_parse_json_from_file(tmp_path):
    test_data = {"key": "value"}
    file_path = tmp_path / "test.json"
    
    with open(file_path, "w") as f:
        json.dump(test_data, f)
    
    result = parse_json_from_file(file_path)
    assert result == test_data
def test_parse_json_file_not_found():
    with pytest.raises(FileNotFoundError):
        parse_json_from_file("non_existent_file.json")


def test_parse_json_invalid_json(tmp_path):
    file_path = tmp_path / "bad.json"

    with open(file_path, "w") as f:
        f.write("not valid json")

    with pytest.raises(json.JSONDecodeError):
        parse_json_from_file(file_path)


def test_choose_sentence_structure():
    result = choose_sentence_structure()
    assert result in structures

def test_get_pronoun():
    result = get_pronoun()
    assert result in pronouns

def test_get_article():
    result = get_article()
    assert result in articles


def test_get_word():
    speech_part = ["wordA", "wordB", "wordC"]
    # A = index 0
    result = get_word("A", speech_part)
    assert result == "wordA"

    # B = index 1
    result = get_word("B", speech_part)
    assert result == "wordB"

def test_fix_agreement():
    sentence = ["he", "quickly", "run"]
    fix_agreement(sentence)
    assert sentence[2] == "runs"

def test_fix_agreement_article_rule():
    sentence = ["a", "big", "apple"]
    fix_agreement(sentence)
    assert sentence[0] == "an"

def test_fix_agreement_the_rule():
    sentence = ["the", "big", "dog", "quickly", "run"]
    fix_agreement(sentence)
    assert sentence[4] == "runs"

def test_fix_agreement_no_changes():
    sentence = ["they", "quickly", "run"]
    original = sentence.copy()
    fix_agreement(sentence)
    assert sentence == original

def test_build_sentence(mocker):
    # Mock random choices to remove randomness
    mocker.patch("build_sentences.get_article", return_value="a")
    mocker.patch("build_sentences.get_pronoun", return_value="he")

    # Minimal deterministic data
    data = {
        "adjectives": ["adj"] * 26,
        "nouns": ["noun"] * 26,
        "verbs": ["run"] * 26,
        "adverbs": ["quickly"] * 26,
        "prepositions": ["with"] * 26,
    }

    seed_word = "ABCDEFG"
    structure = ["PRO", "ADV", "VERB", "ART", "ADJ", "NOUN"]

    result = build_sentence(seed_word, structure, data)

    assert isinstance(result, str)
    assert result[0].isupper()


def test_build_sentence_full_structure(mocker):

    mocker.patch("build_sentences.get_article", return_value="a")
    mocker.patch("build_sentences.get_pronoun", return_value="he")

    data = {
        "adjectives": ["adj"] * 26,
        "nouns": ["apple"] * 26,
        "verbs": ["run"] * 26,
        "adverbs": ["quickly"] * 26,
        "prepositions": ["with"] * 26,
    }

    seed_word = "ABCDEFGH"

    # Esta estructura fuerza TODOS los caminos
    structure = ["PRO","ADV","VERB","ART","ADJ","NOUN","PREP","ART","ADJ","NOUN"]

    result = build_sentence(seed_word, structure, data)

    assert isinstance(result, str)
    assert result[0].isupper()

