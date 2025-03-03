//transform the following to A3.lex
import java_cup.runtime.*;
%%

%implements java_cup.runtime.Scanner
%type Symbol
%function next_token
%class A3Scanner
%eofval{ return null;
%eofval}
%state COMMENT

KEYWORDS = {"WRITE"|"READ"|"IF"|"ELSE"|"RETURN"|"STRING"|"BEGIN"|"END"|"MAIN"|"INT"|"REAL"}
ID = [a-zA-Z][a-zA-Z0-9]*
NUM = [0-9]+(\.[0-9]+)?
QSTRING = \"[^\"]*\"|'[^']*'
%%
<YYINITIAL> "/**" { yybegin(COMMENT); }
<COMMENT> "**/" { yybegin(YYINITIAL); }
<YYINITIAL> "WRITE" { return new Symbol(A3Symbol.WRITE); }
<YYINITIAL> "READ" { return new Symbol(A3Symbol.READ); }
<YYINITIAL> "IF" { return new Symbol(A3Symbol.IF); }
<YYINITIAL> "ELSE" { return new Symbol(A3Symbol.ELSE); }
<YYINITIAL> "RETURN" { return new Symbol(A3Symbol.RETURN); }
<YYINITIAL> "BEGIN" { return new Symbol(A3Symbol.BEGIN); }
<YYINITIAL> "END" { return new Symbol(A3Symbol.END); }
<YYINITIAL> "MAIN" { return new Symbol(A3Symbol.MAIN); }
<YYINITIAL> ("STRING"|"INT"|"REAL") { return new Symbol(A3Symbol.TYPE); }

<YYINITIAL>"+" { return new Symbol(A3Symbol.PLUS); }
<YYINITIAL>"-" { return new Symbol(A3Symbol.MINUS); }
<YYINITIAL>"*" { return new Symbol(A3Symbol.TIMES); }
<YYINITIAL>"/" { return new Symbol(A3Symbol.DIVIDE); }
<YYINITIAL>"(" { return new Symbol(A3Symbol.OPAREN); }
<YYINITIAL>")" { return new Symbol(A3Symbol.CPAREN); }
<YYINITIAL>";" { return new Symbol(A3Symbol.SEMI); }
<YYINITIAL>"!=" { return new Symbol(A3Symbol.NEQUALTO); }
<YYINITIAL>"==" { return new Symbol(A3Symbol.EQUALTO); }
<YYINITIAL>"=" { return new Symbol(A3Symbol.ASSIGN); }
<YYINITIAL>"," { return new Symbol(A3Symbol.COM); }
<YYINITIAL> {QSTRING} { return new Symbol(A3Symbol.QSTRING); }
<YYINITIAL>{ID} { return new Symbol(A3Symbol.ID); }
<YYINITIAL>{NUM} { return new Symbol(A3Symbol.NUM);}  
\r|\n|\t|" " {}

<COMMENT>. {}
<COMMENT>\n|\r {}
. {}