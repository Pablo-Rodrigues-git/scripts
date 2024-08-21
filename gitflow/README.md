# Git Hook Installation Script

We have a script that simplifies the process of installing Git hooks in your local repository. The script copies specified hook files from the `/scripts` directory to the `.git/hooks` directory, making them executable.

### Hook Files

The script installs the following hooks:

- `prepare-commit-msg`
- `pre-commit`
- `pre-push`

### How to Use

1. **Ensure the hook files exist**: Before running the script, ensure that the hook files are present in the `/scripts` directory at the root of your Git repository.

2. **Make the script executable**: If the script is not already executable, run `chmod +x install_hooks.sh` to make it so.

3. **Run the script**: From the root directory of your Git repository, run the script with `./install_hooks.sh`. 

The script will then copy the specified hook files to the `.git/hooks` directory and make them executable. If a specified file does not exist in the `/scripts` directory, the script will print an error message.

_Note: This script assumes that it is being run from the root directory of your Git repository. If you run it from a different location, it may not work as expected._


# Git prepare-commit-msg Hook Script

This is a Bash script that can be used as a Git `prepare-commit-msg` hook. The purpose of this hook is to prepend the branch name to commit messages if it matches a specific format.

### How it Works

When you make a commit, Git automatically invokes the `prepare-commit-msg` hook script (if it exists) to allow you to modify the commit message before it is finalized. This script checks the name of the current branch and compares it to a specific format. If the branch name matches the format, the script extracts the last two groups of the branch name (which are assumed to be alphanumeric) and prepends them to the commit message in the format `[BEESXX-YYYY]`.


# Git Pre-Commit Hook

This script is a Git pre-commit hook that automatically increments the version number of the components in your project. It is designed to work with a specific project structure and naming conventions.

### What it does

1. **Identifies changed files**: The script checks for files that have been changed in the current branch compared to another branch (default is `master`).

2. **Checks for folder-specific changes**: It then checks if any of these changed files belong to specific folders defined in the `folder_version` array. Each folder is associated with a specific version variable in the `build.gradle` file.

3. **Compares and increments versions**: If changes are detected, the script compares the current version of the component (found in `build.gradle`) with the version in the branch to compare with. If the current version is not greater, it is incremented. The increment is a minor version bump for feature branches (branches named `feature/*`) and a patch version bump for all other branches.

4. **Stages the updated `build.gradle` file**: The updated `build.gradle` file is added to the Git staging area.

5. **Updates submodules and stages them**: The script also updates the submodules and stages the `sdk-android-specs` submodule.

### Usage

Run the script before committing your changes. You can also run it with the `--verbose` flag to print more information about the version comparisons being made.

### Note

This script assumes a specific project structure and naming conventions. It may need to be adapted to suit your specific project's requirements.

# Git Pre-Push Hook for Submodule Update and Conflict Check

This script is a pre-push Git hook, which is a script that Git executes before each `git push` operation. The purpose of this script is to perform checks and potentially prevent the push operation if certain conditions are not met.

### What this script does

1. **Submodule update**: The script first updates the `sdk-android-specs` submodule to its latest commit on the remote repository.

2. **Submodule changes check**: After updating the submodule, the script checks if there are any changes in the submodule that have not been committed. If there are such changes, the script prevents the push operation and prints an error message in red.

3. **Branch format and conflict check**: The script also checks if the current branch name matches the format `$type/master/BEESXX-YYYY`. If the branch name matches this format, the script checks if there would be any conflicts when merging the current branch into the `master` branch. If there would be conflicts, the script prevents the push operation and prints an error message in red.

## Bypassing Git Hooks

While Git hooks can be incredibly useful for enforcing certain rules and behaviors, there may be times when you need to bypass them. Here's how you can do it:

### Bypassing Pre-Commit Hook

To bypass the pre-commit hook, you can use the `--no-verify` (or `-n`) option with `git commit`:

```bash
git commit --no-verify
```

This will skip the pre-commit hook and allow you to commit your changes directly.

### Bypassing Pre-Push Hook

Similarly, to bypass the pre-push hook, you can also use the `--no-verify` option, but this time with `git push`:

```bash
git push --no-verify
```

This will skip the pre-push hook and allow you to push your changes directly.

**Note**: Use these commands with caution. The hooks are there for a reason, and bypassing them could potentially allow problematic code to be committed or pushed.
