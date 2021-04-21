"""
    count_word_occurrence_in_file(file_name::String, word::String)

Counts how often word appears in file file_name.
Example: if file contains "one two one two three four"
         And word is "one", then this function returns 2
"""
function count_word_occurrence_in_file(file_name::String, word::String)
    open(file_name, "r") do file
        lines = readlines(file)
        return count(word, join(lines))
    end
end
