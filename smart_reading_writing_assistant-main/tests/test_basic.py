from stage1_spell.spell_checker import SpellChecker

def test_levenshtein():
    assert SpellChecker.levenshtein('kitten','sitting') == 3

def test_common_fix():
    c=SpellChecker()
    fixed, changes=c.correct('I definately recieved the file.')
    assert 'definitely' in fixed.lower()
    assert 'received' in fixed.lower()
    assert len(changes)>=2
