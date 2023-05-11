## ⚠️ Warning ⚠️

This tool can potentially reveal sensitive information about your filesystem, so use it with caution. Do not blindly copy-paste output from this tool into chat sessions or any other public spaces. Always review the output carefully to make sure you are not accidentally revealing any sensitive information.

## Description

`showgpt.sh` is a Bash script that displays the contents of specified files or all files within the current directory (and its subfolders), excluding gitignored files if the current directory is part of a git repo.

## Usage

```
./showgpt.sh [-e exclude_pattern]... [file1] [file2] ...
```

Running the script without any arguments will display the contents of all files within the current directory and its subdirectories, excluding gitignored files if the current directory is part of a git repo. Additional arguments can be specified to display the contents of specific files.

Options:
- `-h`: Displays the usage statement.
- `-e`: Specifies a pattern to exclude files. Can be used multiple times for different patterns. Use quotes to avoid issues with special characters.

## Example

Suppose you have a directory called `my_project` that contains the following files and folders:

```
my_project/
├── README.md
├── src/
│   ├── main.py
│   └── utils.py
└── tests/
    ├── test_main.py
    └── test_utils.py
```

To display the contents of all files in the `my_project` directory and its subdirectories, you can run:

```
./showgpt.sh
```

To display the contents of only the `main.py` file and the `test_main.py` file, you can run:

```
./showgpt.sh src/main.py tests/test_main.py
```

To exclude all files ending in `.py`, you can run:

```
./showgpt.sh -e .py
```

To exclude all files ending in `.py` and `.md`, you can run:

```
./showgpt.sh -e .py -e .md
```

To output the contents of all files in the current directory and its subdirectories to a file called `output.txt`, you can run:

```
./showgpt.sh > output.txt
```

If you run the script from a directory that is part of a git repo, the script will exclude gitignored files from the list of files to display.
