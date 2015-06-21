% kelem is a hack. :/
Nonterminals program list elems elem kelem.
Terminals '(' ')' int bool atom.

Rootsymbol program.

program ->
  list             : ['$1'].
program ->
  list program     : ['$1' | '$2'].
program ->
  kelem program     : ['$1' | '$2' ].   % hack. elem?
program ->
  kelem             : ['$1'].           % hack. elem?

list ->
  '(' ')'          : [].
list ->
  '(' elems ')'    : '$2'.

elems ->
  elem             : ['$1'].
elems ->
  elem elems       : ['$1'|'$2'].

elem -> int        : extract_token('$1').
elem -> bool       : extract_token('$1').
elem -> atom       : extract_token('$1').
elem -> list       : '$1'.

% hack.
kelem -> int        : extract_token('$1').
kelem -> bool       : extract_token('$1').
kelem -> atom       : extract_token('$1').

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
