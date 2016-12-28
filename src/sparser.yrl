Nonterminals program statements statement primitive list elems elem.
Terminals '(' ')' int bool atom string.

Rootsymbol program.

program ->
  statements               : '$1'.

statements ->
  statement statements     : ['$1' | '$2'].
statements ->
  statement                : ['$1'].

statement  ->
  primitive                : '$1'.
statement  ->
  list                     : '$1'.

primitive -> int           : extract_token('$1').
primitive -> bool          : extract_token('$1').
primitive -> atom          : extract_token('$1').
primitive -> string        : extract_token('$1').

list ->
  '(' ')'                  : [].
list ->
  '(' elems ')'            : '$2'.

elems ->
  elem                     : ['$1'].
elems ->
  elem elems               : ['$1'|'$2'].

elem  ->
  primitive                : '$1'.
elem  ->
  list                     : '$1'.

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
