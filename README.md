# Ruby-Linter-for-Python
Ruby linter created to detect style errors for Python files.
PEP 8 Style Guide was used to define the style rules: https://www.python.org/dev/peps/pep-0008/

This Ruby linter can detect the following style errors:

- Line length greater than 79 characters

- Imports should be on separate lines

- Whitespace after parentheses, brackets or braces

- Whitespace before parentheses, brackets or braces

- Whitespace before a comma, semicolon, or colon

- More than one space around an assignment operator

- Use the characters 'l', 'O', or 'I' as single character variable names

- Unindent does not match any outer indentation level

### Good and Bad Practices

Imports should usually be on separate lines:

### Correct:
> import os

> import sys

### Wrong:
> import sys, os

Avoid extraneous whitespace immediately inside parentheses, brackets or braces:

### Correct:
> spam(ham[1], {eggs: 2})

### Wrong:
> spam( ham[ 1 ], { eggs: 2 } )

Avoid extraneous whitespace immediately before a comma, semicolon, or colon:

### Correct:
> if x == 4: print x, y; x, y = y, x

### Wrong:
> if x == 4 : print x , y ; x , y = y , x

## Built With

- Ruby 2.6.5

- RSpec 3.9

## Getting Started

- Download or clone the zip file

- Right-click on the Ruby-Linter-for-Python folder and select Open Terminal Here

- Now use this command to start the program: bin/main.rb

- Paste the path file of your python file, like this /home/user/Projects/Python-test/test.py

![2020-05-15 162312](https://user-images.githubusercontent.com/33432289/82097833-4d700000-96c9-11ea-9320-bf7899d302e6.jpg)

### Prerequisites

- Ruby 2.6.5

- RSpec 3.9

## Authors

👤 **Roberto Perez Jimenez**

- Github: [@LoboArkano](https://github.com/LoboArkano)
- Twitter: [@LoboArcano92](https://twitter.com/LoboArcano92)
- Linkedin: [linkedin](https://www.linkedin.com/in/jos%C3%A9-roberto-p%C3%A9rez-jim%C3%A9nez-97a729195/ )

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/LoboArkano/Ruby-Linter-for-Python/issues).

## Show your support

Give a ⭐️ if you like this project!
 
## 📝 License

This project is MIT licensed.
