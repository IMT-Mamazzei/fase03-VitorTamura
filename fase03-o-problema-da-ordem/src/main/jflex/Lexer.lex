package br.maua.cic303;

import java_cup.runtime.Symbol;

%%

%class Lexer
%public
%unicode
%cup
%line
%column

%{
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

DIGITO = [0-9]
LETRA = [a-zA-Z_]
ID = {LETRA}({LETRA}|{DIGITO})*
NUM = {DIGITO}+

ESPACO = [ \t\r\n\f]+

%%

{ESPACO}        { }

"if"            { return symbol(sym.IF); }
"then"          { return symbol(sym.THEN); }
"else"          { return symbol(sym.ELSE); }
"while"         { return symbol(sym.WHILE); }

"=="            { return symbol(sym.EQ); }
"!="            { return symbol(sym.NEQ); }
"<="            { return symbol(sym.LE); }
">="            { return symbol(sym.GE); }
"<"             { return symbol(sym.LT); }
">"             { return symbol(sym.GT); }

"="             { return symbol(sym.ASSIGN); }

"+"             { return symbol(sym.PLUS); }
"-"             { return symbol(sym.MINUS); }
"*"             { return symbol(sym.TIMES); }
"/"             { return symbol(sym.DIVIDE); }
"%"             { return symbol(sym.MOD); }

";"             { return symbol(sym.SEMI); }
"("             { return symbol(sym.LPAREN); }
")"             { return symbol(sym.RPAREN); }
"{"             { return symbol(sym.LBRACE); }
"}"             { return symbol(sym.RBRACE); }

{NUM}           { return symbol(sym.NUM, Integer.valueOf(yytext())); }
{ID}            { return symbol(sym.ID, yytext()); }

.               { throw new RuntimeException("Caractere inválido: " + yytext()); }