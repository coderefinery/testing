---
layout: episode
title: "Exercise: Testing with pytest"
teaching: 10
exercises: 20
questions:
  - "How can we implement a test suite using pytest?"
  - "I am a Fortran developer, do I need to care about pytest?"
objectives:
  - "Write me."
keypoints:
  - "Write me."
---

```python
def reverse_string(s):
    """
    Reverses order or characters in string s.
    """
    return s[::-1]


def test_reverse_string():
    assert reverse_string('foobar!') == '!raboof'
    assert reverse_string('stressed') == 'desserts'


def reverse_words(s):
    """
    Reverses order or words in string s.
    """
    words = s.split()
    words_reversed = words[::-1]
    return ' '.join(words_reversed)


def test_reverse_words():
    assert reverse_words('dogs hate cats') == 'cats hate dogs'
    assert reverse_words('dog eat dog') == 'dog eat dog'
    assert reverse_words('one two three four') == 'four three two one'


def get_word_lengths(s):
    """
    Returns a list of integers representing
    the word lengths in string s.
    """
    return [len(word) for word in s.split()]


def test_get_word_lengths():
    text = "Three tomatoes are walking down the street"
    assert get_word_lengths(text) == [5, 8, 3, 7, 4, 3, 6]
```
