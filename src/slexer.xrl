Definitions.

INT        = [0-9]+
ATOM       = [a-z_0-9\?\&\-\*\^\+]+
WHITESPACE = [\s\t\n\r]
COMMENT    = ;.*\n

Rules.

{INT}         : {token, {int,  TokenLine, list_to_integer(TokenChars)}}.
\#t           : {token, {bool, TokenLine, true}}.
\#f           : {token, {bool, TokenLine, false}}.
{COMMENT}     : skip_token.
{ATOM}        : {token, {atom, TokenLine, to_atom(TokenChars)}}.
\(            : {token, {'(',  TokenLine}}.
\)            : {token, {')',  TokenLine}}.
'[a-z]        : {skip_token, transform_to_quote(TokenChars)}.
'\([^\)]*\)   : {skip_token, transform_to_quote(TokenChars)}.
{WHITESPACE}+ : skip_token.

Erlang code.

transform_to_quote([_Quote|Body]) ->
  PushBack = "(quote " ++ Body ++ ")",
  PushBack.

to_atom(Chars) ->
  list_to_atom(Chars).
