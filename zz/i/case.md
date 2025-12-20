## Bash `case` Statement:  A Powerful Multi-Way Branching Tool

The `case` statement in Bash provides a structured way to perform different actions based on the value of a single variable.  It's similar to `switch` statements in other programming languages.  It's an excellent alternative to nested `if-elif-else` structures when you need to check for several specific values.

**Syntax:**

```bash
case $variable in
  pattern1 )
    # Commands to execute if $variable matches pattern1
    ;;
  pattern2 )
    # Commands to execute if $variable matches pattern2
    ;;
  pattern3 )
    # Commands to execute if $variable matches pattern3
    ;;
  * )  # Optional: Default case (often called "else" in other languages)
    # Commands to execute if no other pattern matches
    ;;
esac
```

**Explanation:**

* **`case $variable in`**:  The statement begins with the keyword `case`, followed by the variable you want to evaluate and the keyword `in`.
* **`pattern1 )`**, **`pattern2 )`**, etc.: Each possible value (or pattern) is listed, followed by a closing parenthesis `)`.
* **`# Commands to execute...`**: These are the commands that will be executed if the variable's value matches the corresponding pattern.  You can include any valid Bash commands here.
* **`;;`**:  **Crucially important!**  The double semicolon `;;` acts as a `break` statement.  When a match is found and the corresponding commands are executed, the `case` statement stops and execution continues after the `esac`.  If you forget the `;;`, execution will "fall through" to the next pattern's commands, which is usually not what you want.
* **`* )`**:  This is the default pattern, represented by the asterisk (`*`).  It's like the `else` clause in an `if-else` statement.  If the variable doesn't match any of the other patterns, the commands under the `*` pattern will be executed.  It's good practice to include a default case to handle unexpected input.
* **`esac`**: The `case` statement is closed with the keyword `esac` (which is just `case` spelled backward).

**Patterns:**

The patterns you use in the `case` statement can be more than just simple string literals.  They can include:

* **Literal strings:**  `"value1"`, `"another_value"`
* **Wildcard characters:**
    * `?`: Matches any single character.
    * `*`: Matches zero or more characters.
    * `[characters]`: Matches any single character from the specified set (e.g., `[aeiou]` matches any vowel).
    * `[!characters]`: Matches any single character *not* in the specified set.
* **Pipes for multiple patterns:** `pattern1 | pattern2 | pattern3` (matches any of the patterns).

**Examples:**

**1. Simple Menu:**

```bash
#!/bin/bash

echo "Choose an option:"
echo "1. Start"
echo "2. Stop"
echo "3. Restart"
echo "4. Exit"

read -p "Enter your choice (1-4): " choice

case $choice in
  1 )
    echo "Starting the service..."
    # Start service commands here
    ;;
  2 )
    echo "Stopping the service..."
    # Stop service commands here
    ;;
  3 )
    echo "Restarting the service..."
    # Restart service commands here
    ;;
  4 )
    echo "Exiting..."
    exit 0
    ;;
  * )
    echo "Invalid choice. Please enter a number between 1 and 4."
    ;;
esac

echo "Done."
```

**2. Checking File Type:**

```bash
#!/bin/bash

file_name="$1"

case "$file_name" in
  *.txt )
    echo "$file_name is a text file."
    ;;
  *.jpg | *.jpeg | *.png | *.gif )
    echo "$file_name is an image file."
    ;;
  *.sh )
    echo "$file_name is a shell script."
    ;;
  *)
    echo "$file_name is not a recognized file type."
    ;;
esac
```

**3.  Using Wildcards:**

```bash
#!/bin/bash

input="apple"

case "$input" in
  a* )
    echo "$input starts with 'a'."
    ;;
  b?nana )
    echo "$input matches 'b' followed by any character followed by 'nana'."
    ;;
  * )
    echo "$input does not match any defined pattern."
    ;;
esac
```

**4. Handling Empty Input:**

```bash
#!/bin/bash

read -p "Enter some text: " input

case "$input" in
  "" )
    echo "You entered nothing!"
    ;;
  * )
    echo "You entered: $input"
    ;;
esac
```

**Best Practices and Common Mistakes:**

* **Always use `;;`**:  Forgetting the double semicolon is the most common error.  It will lead to unexpected behavior.
* **Quote variables:**  Enclose the variable being evaluated in double quotes (`"$variable"`).  This prevents issues with word splitting and globbing, especially when the variable might contain spaces or special characters.
* **Order matters:**  The `case` statement evaluates the patterns in the order they appear. If a variable matches multiple patterns, only the commands associated with the *first* matching pattern will be executed.
* **Use a default case:** Including `* )` as the last pattern is a good practice to handle unexpected or invalid input gracefully.
* **Readability:** Use indentation to make your `case` statements easier to read and understand.
* **Consider `select`:** For simple menus, the `select` command can be even more concise than a `case` statement.

**When to use `case` vs. `if-elif-else`:**

* **`case`:**  Best when you need to compare a single variable against a specific set of values or patterns.  It's often cleaner and more readable than a long chain of `if-elif-else` statements in these scenarios.
* **`if-elif-else`:** More flexible when you need to test complex conditions that involve multiple variables or logical operators (e.g., `if [ $x -gt 10 ] && [ $y -lt 5 ]; then ...`).

In summary, the `case` statement is a powerful and versatile tool in Bash scripting that provides a structured and readable way to handle multi-way branching based on the value of a variable. Understanding its syntax, patterns, and best practices will help you write more efficient and maintainable scripts.
