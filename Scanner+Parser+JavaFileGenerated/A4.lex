import java_cup.runtime.*;
%%

%implements java_cup.runtime.Scanner
%type Symbol
%function next_token
%class A4Scanner
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
<YYINITIAL> "WRITE" { return new Symbol(A4Symbol.WRITE); }
<YYINITIAL> "READ" { return new Symbol(A4Symbol.READ); }
<YYINITIAL> "IF" { return new Symbol(A4Symbol.IF); }
<YYINITIAL> "ELSE" { return new Symbol(A4Symbol.ELSE); }
<YYINITIAL> "RETURN" { return new Symbol(A4Symbol.RETURN); }
<YYINITIAL> "BEGIN" { return new Symbol(A4Symbol.BEGIN); }
<YYINITIAL> "END" { return new Symbol(A4Symbol.END); }
<YYINITIAL> "MAIN" { return new Symbol(A4Symbol.MAIN); }
<YYINITIAL> "STRING" { return new Symbol(A4Symbol.STRING); }
<YYINITIAL> "INT" {return new Symbol(A4Symbol.INT); }
<YYINITIAL> "REAL" {return new Symbol(A4Symbol.REAL); }
<YYINITIAL> "TRUE" {return new Symbol(A4Symbol.TRUE); }
<YYINITIAL> "FALSE" { return new Symbol(A4Symbol.FALSE); }

<YYINITIAL>"+" { return new Symbol(A4Symbol.PLUS); }
<YYINITIAL>"-" { return new Symbol(A4Symbol.MINUS); }
<YYINITIAL>"*" { return new Symbol(A4Symbol.TIMES); }
<YYINITIAL>"/" { return new Symbol(A4Symbol.DIVIDE); }
<YYINITIAL>"(" { return new Symbol(A4Symbol.OPAREN); }
<YYINITIAL>")" { return new Symbol(A4Symbol.CPAREN); }
<YYINITIAL>";" { return new Symbol(A4Symbol.SEMI); }
<YYINITIAL>"!=" { return new Symbol(A4Symbol.NEQUALTO); }
<YYINITIAL>"==" { return new Symbol(A4Symbol.EQUALTO); }
<YYINITIAL>"=" { return new Symbol(A4Symbol.ASSIGN); }
<YYINITIAL>"," { return new Symbol(A4Symbol.COM); }
<YYINITIAL> {QSTRING} { return new Symbol(A4Symbol.QSTRING, yytext().replaceAll("\'", "\"")); }
<YYINITIAL>{ID} { return new Symbol(A4Symbol.ID, yytext()); }
<YYINITIAL>{NUM} { return new Symbol(A4Symbol.NUM, yytext());}  
\r|\n|\t|" " {}

<COMMENT>. {}
<COMMENT>\n|\r {}
. {}