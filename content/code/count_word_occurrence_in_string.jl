"""
    count_word_occurrence_in_string(text::String, word::String)

Count how often word appears in text.
Example: if `text` is "one two one two three four"
and `word` is "one", then this function returns 2
"""
function count_word_occurrence_in_string(text::String, word::String)

    return count(word, text)

end
