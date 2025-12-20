Let's delve into the world of `sed` (Stream EDitor) in Bash. `sed` is a powerful, non-interactive command-line text editor. It reads input line by line, applies commands, and writes the modified output to the standard output.  It's incredibly useful for searching, replacing, deleting, and transforming text in files and streams.

**Core Concepts**

* **Stream Editor:** `sed` processes text in a stream, meaning it operates on lines one at a time without loading the entire file into memory. This makes it efficient for handling large files.
* **Non-Interactive:** Unlike text editors like `vi` or `nano`, `sed` doesn't require interactive input.  You provide all the commands upfront.
* **Commands:** `sed` operates using commands that tell it what to do with each line of text.
* **Addresses (Optional):**  You can specify addresses (line numbers, patterns, or ranges) to limit the commands to specific lines.
* **Regular Expressions:** `sed` heavily relies on regular expressions for pattern matching, which enables very flexible text manipulation.
* **Standard Output:** By default, `sed` writes the modified output to the standard output (your terminal).  You need to use the `-i` option to modify the file in place.

**Basic Syntax**

```bash
sed [options] 'command' [input_file(s)]
```

* **`sed`:** The command itself.
* **`[options]`:**  Various options that modify `sed`'s behavior. Common options include:
    * `-i` (in-place): Modifies the file directly.  **Caution:  Back up your files before using `-i`!** Some versions of `sed` (like GNU `sed`) support `-i.bak` to create a backup with a `.bak` extension.
    * `-n` (suppress automatic printing):  Only print lines explicitly requested (using the `p` command, for example).
    * `-e 'command'` (expression):  Specifies a command to execute. You can use multiple `-e` options to execute multiple commands.  Generally, if you only have one command, you don't need to use `-e`.
    * `-f script_file` (file): Reads `sed` commands from a file.
    * `-r` or `-E` (extended regular expressions):  Enables extended regular expressions, which provide more features and a cleaner syntax.
* **`'command'`:** The `sed` command to execute.  The command is enclosed in single quotes to prevent the shell from interpreting any special characters within the command.
* **`[input_file(s)]`:** The file(s) that `sed` will process. If no file is specified, `sed` reads from standard input.

**Common `sed` Commands**

Here's a rundown of some of the most frequently used `sed` commands:

* **`s/pattern/replacement/flags` (Substitute):**  Replaces the first occurrence of `pattern` with `replacement` on each line.
    * `g` (global): Replace all occurrences of `pattern` on a line.
    * `i` (ignore case): Perform case-insensitive matching.
    * `1`, `2`, ..., `n`: Replace only the *n*th occurrence.
    * `p` (print): Print the modified line.  Often used with `-n`.
    * `w file` (write): Write the modified line to a file.

* **`d` (Delete):** Deletes a line.

* **`p` (Print):** Prints a line.  Usually used with `-n` to selectively print.

* **`a\text` (Append):** Appends `text` after the current line. The backslash is crucial.

* **`i\text` (Insert):** Inserts `text` before the current line. The backslash is crucial.

* **`c\text` (Change):** Replaces the entire current line with `text`. The backslash is crucial.

* **`y/chars1/chars2/` (Transform):** Translates characters in `chars1` to the corresponding characters in `chars2`.  Like the `tr` command.

* **`=` (Line Number):** Prints the line number of the current line.

* **`:` (Label):**  Defines a label for branching.
* **`b label` (Branch):** Branches to a label.
* **`t label` (Test):** Branches to a label if a substitution has been made since the last input line was read or conditional branch.

**Addressing**

You can specify addresses before the command to restrict its execution to specific lines.

* **Line Numbers:**
    * `10d`: Delete line 10.
    * `1,5d`: Delete lines 1 through 5.
    * `5,$d`: Delete lines 5 through the end of the file (`$`).
* **Regular Expression Patterns:**
    * `/pattern/d`: Delete lines that match the pattern.
    * `/start/,/end/d`: Delete lines from the first line matching `start` to the first line matching `end`.
* **Combined:**
    * `5,/pattern/d`: Delete from line 5 to the first line matching the pattern.

**Examples**

Let's illustrate with practical examples:

1. **Replace "foo" with "bar" in a file (and print to standard output):**

   ```bash
   sed 's/foo/bar/' myfile.txt
   ```

2. **Replace all occurrences of "foo" with "bar" in a file (and print to standard output):**

   ```bash
   sed 's/foo/bar/g' myfile.txt
   ```

3. **Replace "foo" with "bar" in a file and modify the file in place:**

   ```bash
   sed -i 's/foo/bar/g' myfile.txt
   ```

   **Important:** This changes `myfile.txt` directly.  Use with caution!  Consider backing up the file first.

   ```bash
   # With GNU sed, create a backup
   sed -i.bak 's/foo/bar/g' myfile.txt
   ```

4. **Delete all lines containing the word "error":**

   ```bash
   sed '/error/d' myfile.txt
   ```

5. **Print only lines containing the word "important":**

   ```bash
   sed -n '/important/p' myfile.txt
   ```

6. **Delete the first 10 lines of a file:**

   ```bash
   sed '1,10d' myfile.txt
   ```

7. **Insert a line before each line containing "title":**

   ```bash
   sed 'i\
   This is a new line before the title
   ' myfile.txt
   ```
   (Note the backslash and the newline after `i\`. The text to be inserted must start on a new line)

8. **Append a line after each line containing "summary":**

   ```bash
   sed 'a\
   This is a new line after the summary
   ' myfile.txt
   ```

9. **Replace a specific line:**

   ```bash
   sed '5c\
   This is the new content of line 5
   ' myfile.txt
   ```

10. **Replace all occurrences of "apple" with "orange", ignoring case:**

   ```bash
   sed 's/apple/orange/gi' myfile.txt
   ```

11. **Remove blank lines:**

   ```bash
   sed '/^$/d' myfile.txt
   ```

12. **Remove leading whitespace from each line:**

   ```bash
   sed 's/^[ \t]*//' myfile.txt
   ```

13. **Extract the first word from each line:**

   ```bash
   sed 's/\s.*//' myfile.txt
   ```

14. **Use a variable in the `sed` command:**

   ```bash
   my_variable="important"
   sed -n "/$my_variable/p" myfile.txt
   ```

15. **Read `sed` commands from a file:**

   Create a file (e.g., `commands.sed`) with your `sed` commands, one command per line:

   ```
   s/foo/bar/g
   /^$/d
   ```

   Then run:

   ```bash
   sed -f commands.sed myfile.txt
   ```

16. **Using Extended Regular Expressions:**

   ```bash
   sed -E 's/(apple|banana)/fruit/g' myfile.txt
   ```
   This replaces all occurrences of "apple" or "banana" with "fruit".  The `-E` option allows you to use `|` for alternation in the regular expression.

**Important Considerations and Best Practices**

* **Backups:** Always, always, always back up your files before using `sed -i`.  A simple mistake in your command can irreversibly alter your data.
* **Quoting:** Use single quotes (`'`) to enclose your `sed` commands. This prevents the shell from interpreting special characters. If you need to use a single quote *within* the command, escape it (`\'`).
* **Regular Expression Escaping:** Be mindful of characters that have special meanings in regular expressions (e.g., `.`, `*`, `+`, `?`, `[`, `]`, `(`, `)`, `^`, `$`, `\`, `|`).  Escape them with a backslash (`\`) if you want to treat them literally.
* **Delimiter:** While `/` is the most common delimiter for the `s` command, you can use other characters if the pattern contains slashes.  For example: `sed 's#foo/bar#baz#g' myfile.txt`
* **Testing:**  Test your `sed` commands without the `-i` option first to verify that they are doing what you expect.
* **Complexity:** For very complex text manipulation tasks, consider using more powerful scripting languages like `awk` or `Perl`.

**In summary, `sed` is an indispensable tool for command-line text processing.  Mastering its commands and regular expressions will significantly enhance your ability to manipulate text data efficiently.**  Experiment with the examples and practice using different commands and options to become proficient with `sed`.  Don't forget to consult the `man sed` page for the full documentation.
