# Lighthouse Scheme

A toy Scheme-like language built on top of Elixir, just for fun.

[![ScreenShot](https://raw.githubusercontent.com/jwhiteman/lighthouse-scheme/master/resources/schemer.png)](https://vimeo.com/131496359)

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
