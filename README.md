# Lighthouse Scheme

A very small Scheme-like language built on top of Elixir.

[![ScreenShot](https://raw.githubusercontent.com/jwhiteman/lighthouse-scheme/master/resources/schemer.png)](https://vimeo.com/131496359)

Built for those who want to hack on Scheme and Elixir and recursive ideas.

In action:

https://vimeo.com/131496359

## Running the REPL

From the command line:

```bash
./lighthouse
```

You can also access the repl from inside `iex`:

```elixir
# iex -S mix
Scheme.repl
```

## Running a file

```bash
./lighthouse path-to-file.scm
```

*Note the file extension must be `.scm`*

## Running tests for the library

As it stands there is a small standard library and test framework.

To run the tests:

```bash
bin/run-tests
```

## Helping Out

PRs welcome. See the TODO.md if you'd like.
