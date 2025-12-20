## Bash `sed` (Stream EDitor)

`sed` is a powerful stream editor used in Bash scripting and command-line environments. It's designed to perform basic text transformations on an input stream (like files, pipes, or standard input) and output the modified stream. `sed` operates on a line-by-line basis, reading each line, applying specified commands, and then outputting the result.

**Key Features and Concepts:**

* **Stream Editor:** `sed` doesn't modify the input file directly unless explicitly instructed to do so (using the `-i` option, which should be used with caution).  Instead, it outputs the modified stream.
* **Line-Oriented:** `sed` processes input one line at a time.
* **Pattern Matching (Regular Expressions):**  `sed` excels at using regular expressions to locate specific patterns in the input lines.
* **Commands:**  `sed` performs actions based on a series of commands that you specify.  These commands can include substitution, deletion, insertion, appending, and more.
* **Addresses:** You can specify addresses (line numbers or patterns) to which commands should be applied.  This allows you to target specific lines or ranges of lines.
* **Scripting:** `sed` commands can be grouped into a script for more complex operations.

**Basic Syntax:**

```bash
sed [options] 'command' [input_file(s)]
```

Or, using a script file:

```bash
sed [options] -f script_file [input_file(s)]
```

**Common Options:**

* `-n`:  Suppresses automatic printing of every line.  Use this when you only want to print lines that are explicitly acted upon by a command.
* `-i[SUFFIX]`:  Edit the file in-place.  **Use with caution!**  If you provide a `SUFFIX` (e.g., `-i.bak`), `sed` creates a backup of the original file with that suffix before modifying it.  If you specify `-i`, without a suffix, there won't be a backup.
* `-e 'command'`:  Add the script 'command' to the commands to be executed.  Useful when you need to chain multiple commands.
* `-f script_file`:  Read `sed` commands from the script file `script_file`.
* `-r`:  Use extended regular expressions (ERE).  Often makes complex patterns easier to write.
* `-s`:  Treat multiple input files as separate streams rather than a single continuous stream. (Useful with the `$` address for last line, for example)

**Common Commands:**

Here's a rundown of some of the most frequently used `sed` commands:

* **`s/pattern/replacement/[flags]` (Substitute):** This is the most common command.  It searches for `pattern` (a regular expression) and replaces it with `replacement`.  The `flags` modify the substitution behavior.

   * `g`:  Replace all occurrences of the pattern on the line, not just the first.
   * `i`:  Perform a case-insensitive search.
   * `[number]`: Replace only the nth occurrence of the pattern on the line.
   * `p`:  Print the line if a replacement was made (often used with `-n`).
   * `w filename`: Write the modified line to the specified `filename`.

* **`d` (Delete):**  Deletes the line.

* **`p` (Print):**  Prints the line.  This is usually suppressed by `-n`, so you'll only see lines explicitly printed by this command.

* **`a\ text` (Append):**  Appends `text` after the current line.  The `\` is essential.

* **`i\ text` (Insert):**  Inserts `text` before the current line. The `\` is essential.

* **`c\ text` (Change):**  Replaces the entire line with `text`.  The `\` is essential.

* **`y/set1/set2/` (Transform):**  Replaces each character in `set1` with the corresponding character in `set2`.

* **`q` (Quit):**  Quit processing the file.

* **`=` (Print Line Number):**  Prints the line number before the line.

* **`{}` (Grouping Commands):**  Allows you to group multiple commands to be executed on the same address.

**Addresses:**

Addresses specify which lines the `sed` command should be applied to.  Addresses can be:

* **Line Number:**  A single number (e.g., `10` for the 10th line).
* **`$` (Last Line):** Represents the last line of the input.
* **`/pattern/` (Regular Expression):**  Lines that match the regular expression.
* **Range:**  A combination of line numbers, `$`, or patterns, separated by a comma (e.g., `1,5` for lines 1 through 5; `/start/,/end/` for lines between the lines matching the "start" and "end" patterns).
* **`$` (last line)**: e.g., `sed '$d' file`  - delete the last line

**Examples:**

1. **Replace all occurrences of "foo" with "bar" in a file:**

   ```bash
   sed 's/foo/bar/g' input.txt
   ```

2. **Replace the first occurrence of "foo" with "bar" only on line 5:**

   ```bash
   sed '5s/foo/bar/' input.txt
   ```

3. **Delete lines containing the word "error":**

   ```bash
   sed '/error/d' input.txt
   ```

4. **Print only lines containing the word "important":**

   ```bash
   sed -n '/important/p' input.txt
   ```

5. **Append "This is a new line" after every line that contains "data":**

   ```bash
   sed '/data/a\This is a new line' input.txt
   ```

6. **Insert "Header:" before the first line of the file:**

   ```bash
   sed '1i\Header:' input.txt
   ```

7. **Delete lines 10 through 20:**

   ```bash
   sed '10,20d' input.txt
   ```

8. **Replace all uppercase letters with lowercase letters:**

   ```bash
   sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/' input.txt
   ```

9. **Remove blank lines:**

   ```bash
   sed '/^$/d' input.txt
   ```

10. **Edit a file in-place and create a backup:**

    ```bash
    sed -i.bak 's/old/new/g' input.txt
    ```
    This command will replace all occurrences of "old" with "new" in `input.txt` and create a backup of the original file named `input.txt.bak`.

11. **Using `-r` for extended regular expressions (more readable in some cases):**

    ```bash
    sed -r 's/(foo|bar)/baz/g' input.txt  # Replaces "foo" or "bar" with "baz"
    ```

12. **Using `-e` to chain commands:**

    ```bash
    sed -e 's/foo/bar/g' -e '/baz/d' input.txt  # Replaces "foo" with "bar" AND deletes lines containing "baz"
    ```

13. **Using a `sed` script:**

    ```bash
    # Create a file named my_sed_script.sed
    # with the following contents:
    # s/old_pattern/new_pattern/g
    # /pattern_to_delete/d

    sed -f my_sed_script.sed input.txt
    ```

**Regular Expressions in `sed`:**

`sed` uses basic regular expressions (BRE) by default.  Common BRE characters:

* `.` (dot): Matches any single character (except newline).
* `*`: Matches the preceding character zero or more times.
* `^`: Matches the beginning of the line.
* `$`: Matches the end of the line.
* `[]`: Character class (e.g., `[aeiou]` matches any vowel).
* `[^]`: Negated character class (e.g., `[^0-9]` matches any non-digit).
* `\`: Escape character. Use `\.`, `\*`, `\^`, `\$`, `\[`, `\]` to match a literal dot, asterisk, caret, dollar sign, square brackets.
* `\(` and `\)`: Capture groups. Used for backreferences in the replacement string (e.g., `\1`, `\2`, etc.).
* `\{m,n\}`: Match the preceding character at least `m` and at most `n` times.

When using `-r` for Extended Regular Expressions (ERE):

* `|`: OR operator. (e.g., `foo|bar` matches either "foo" or "bar").
* `+`: Matches the preceding character one or more times.
* `?`: Matches the preceding character zero or one time.
* `()`: Capture groups (without escaping).
* `{m,n}`: Match the preceding character at least `m` and at most `n` times (without escaping).

**Important Notes:**

* **Backup Before In-Place Editing:**  Always back up your files before using the `-i` option. It's very easy to accidentally make irreversible changes.
* **Quoting:**  Use single quotes (`'`) around `sed` commands to prevent the shell from interpreting special characters within the command. If you need to use shell variables inside the `sed` command, you can use double quotes (`"`) but be careful to escape any characters that might be interpreted by the shell.
* **Complexity:** `sed` can become very complex for advanced text manipulation. For more complex tasks, consider using `awk` or a scripting language like Python or Perl.
* **Platform Differences:**  `sed` implementations can vary slightly between different operating systems (e.g., GNU `sed` vs. BSD `sed`).  If you're writing scripts that need to be portable, be aware of these differences and test your scripts on different platforms.

By mastering `sed`, you'll be able to automate text processing tasks, filter data, and perform powerful transformations directly from the command line or within your Bash scripts. Remember to practice and experiment to get comfortable with its syntax and capabilities.

