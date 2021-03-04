%{
#include <math.h>
#include <stdio.h>
#include<stdlib.h>
#include "famTree.tab.h"
int i;
int j,r;
int date[8];
%}
%option noinput nounput
%%
(?i:IMPRIME)         {return IMPRIME;}
(?i:CRIAR)           {return CRIAR;}
(?i:PAI)             {yylval.num = PAI; return PAI;}
(?i:MAE)             {yylval.num = MAE; return MAE;}
(?i:AVOM)            {yylval.num = AVOM; return AVOM;}
(?i:AVOP)            {yylval.num = AVOP; return AVOP;}
(?i:AVM)             {yylval.num = AVM; return AVM;}
(?i:AVP)             {yylval.num = AVP; return AVP;}
(?i:FILHO)           {yylval.num = FILHO; return FILHO;}
\n                   {return SEP;}
[()+*-]                {return yytext[0];}
(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](1[0-9]{3}|2[0-9]{3}) {r = 0;
									  i = 0;
									  j = 0; 
	                                                                  for (i=0;i<2;i++){
		                                                          	date[j]=yytext[i] - '0';
		                                                                r+=date[j]*pow(10,(1-j));
		                                                                j++;
	                                                                  }
	                                                                  for (i=3;i<5;i++){
		                                                                date[j]=yytext[i] - '0';
		                                                                r+=date[j]*pow(10,(5-j));
		                                                                j++;
	                                                                  }
	                                                                  for (i=6;i<10;i++){
		                                                          	date[j]=yytext[i] - '0';
		                                                          	r+=date[j]*pow(10,(11-j));
		                                                                j++;
	                                                                  }
                                                                          yylval.num = (int) r; 
									  return DATA;
									  }
[a-zA-Z][a-zA-Z0-9]* {yylval.texto = strdup(yytext);return id;}
\"[^"]*\"   {yylval.texto = strdup(yytext);return NOME;}
. 

%%
int yywrap(){
	return 1;
}
