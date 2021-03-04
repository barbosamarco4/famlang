%{
#include <stdlib.h>
#include <stdio.h>
#include "grafos/grafos.h"
#define TAM 10
extern int yylex();
extern char *yytext;
extern int yylineno;
void yyerror(char*);
Grafo *g;
Grafo t;
int p1,p2;
%}

%union {
	char *texto;
	int  num;
       }

%token PAI MAE AVOM AVOP AVM AVP FILHO
%token id
%token NOME
%token SEP
%token DATA
%token IMPRIME IMPRIMEF
%token CRIAR

%type<texto> Membro
%type<texto> NOME
%type<texto> id
%type<texto> Pessoa
%type<texto> idFam
%type<num> DATA
%type<num> PAI MAE AVOM AVOP AVM AVP FILHO

%%
Comandos:Comandos Comando SEP       {printf("\n>>");}
	|
	;
Comando :Entrada           //cada comando permite introduzir algo novo no
        |Consulta          //grafo ou consultar o que lá existe	;
	;
// inserir membros pertencentes a cada familia / relacoes / anexos

Entrada : Relacao
	| Membro
	| Evento
	| CRIAR          {t = createG(TAM);g = &t;}
	|
	;
Relacao :PAI   Pessoa Pessoa             {p1=lookup(*g,$2);
                                          p2=lookup(*g,$3);
					  if((*g)->tab[p1].status != OCUPADO)
					  	fprintf(stderr,"A primeira pessoa não existe no grafo\n");
					  else if((*g)->tab[p1].status != OCUPADO)
                                                fprintf(stderr,"A segunda pessoa não existe no grafo\n");
					  else{
					  	//verificar se $2 é do sexo masculino
                		          	if((*g)->tab[p1].genero != 'f'){
					  		addRel(*g,p1,$1,$3);
					  		addRel(*g,p2,264,$2);
						}
						else
							fprintf(stderr,"A primeira pessoa tem de ser do sexo masculino\n");
					  }
                                         }

        |MAE   Pessoa Pessoa             {p1=lookup(*g,$2);
                                          p2=lookup(*g,$3);
					  if((*g)->tab[p1].status != OCUPADO)
					  	fprintf(stderr,"A primeira pessoa não existe no grafo\n");
					  else if((*g)->tab[p2].status != OCUPADO)
                                                fprintf(stderr,"A segunda pessoa não existe no grafo\n");
					  else{
					  	//verificar se $2 é do sexo feminino
                		          	if((*g)->tab[p1].genero != 'm'){
					  		addRel(*g,p1,$1,$3);
					  		addRel(*g,p2,264,$2);
						}
						else
							fprintf(stderr,"A primeira pessoa tem de ser do sexo feminino\n");
					  }
                                         }

	|FILHO Pessoa Pessoa             {p1=lookup(*g,$2);
                                          p2=lookup(*g,$3);
					  if((*g)->tab[p1].status != OCUPADO)
					  	fprintf(stderr,"A primeira pessoa não existe no grafo\n");
					  else if((*g)->tab[p1].status != OCUPADO)
                                                fprintf(stderr,"A segunda pessoa não existe no grafo\n");
					  else
					  	addRel(*g,p1,$1,$3);
						//se for do sexo feminino
                		          	if((*g)->tab[p2].genero != 'm')
					  		addRel(*g,p2,259,$2);
						//se for do sexo masculino
                		          	if((*g)->tab[p2].genero != 'f')
							addRel(*g,p2,258,$2);
                                         }
	
	|AVOM  Pessoa Pessoa             {p1=lookup(*g,$2);
                                          p2=lookup(*g,$3);
					  if((*g)->tab[p1].status != OCUPADO)
					  	fprintf(stderr,"A primeira pessoa não existe no grafo\n");
					  else if((*g)->tab[p2].status != OCUPADO)
                                                fprintf(stderr,"A segunda pessoa não existe no grafo\n");
					  else{
					  	//verificar se $2 é do sexo masculino
                		          	if((*g)->tab[p1].genero != 'f'){
					  		addRel(*g,p1,$1,$3);
					  		addRel(*g,p2,0,$2);
						}
						else
							fprintf(stderr,"A primeira pessoa tem de ser do sexo masculino\n");
					  }
                                         }

	|AVOP  Pessoa Pessoa             {p1=lookup(*g,$2);
                                          p2=lookup(*g,$3);
					  if((*g)->tab[p1].status != OCUPADO)
					  	fprintf(stderr,"A primeira pessoa não existe no grafo\n");
					  else if((*g)->tab[p2].status != OCUPADO)
                                                fprintf(stderr,"A segunda pessoa não existe no grafo\n");
					  else{
					  	//verificar se $2 é do sexo masculino
                		          	if((*g)->tab[p1].genero != 'f'){
					  		addRel(*g,p1,$1,$3);
					  		addRel(*g,p2,0,$2);
						}
						else
							fprintf(stderr,"A primeira pessoa tem de ser do sexo masculino\n");
					  }
                                         }

      
	|AVM   Pessoa Pessoa             {p1=lookup(*g,$3);
                                          p2=lookup(*g,$3);
					  if((*g)->tab[p1].status != OCUPADO)
					  	fprintf(stderr,"A primeira pessoa não existe no grafo\n");
					  else if((*g)->tab[p2].status != OCUPADO)
                                                fprintf(stderr,"A segunda pessoa não existe no grafo\n");
					  else{
					  	//verificar se $1 é do sexo feminino
                		          	if((*g)->tab[p1].genero != 'm'){
					  		addRel(*g,p1,$1,$3);
					  		addRel(*g,p2,0,$2);
						}
						else
							fprintf(stderr,"A primeira pessoa tem de ser do sexo feminino\n");
					  }
                                         }
   
    
	|AVP   Pessoa Pessoa             {p1=lookup(*g,$3);
                                          p2=lookup(*g,$3);
					  if((*g)->tab[p1].status != OCUPADO)
					  	fprintf(stderr,"A primeira pessoa não existe no grafo\n");
					  else if((*g)->tab[p2].status != OCUPADO)
                                                fprintf(stderr,"A segunda pessoa não existe no grafo\n");
					  else{
					  	//verificar se $1 é do sexo feminino
                		          	if((*g)->tab[p1].genero != 'm'){
					  		addRel(*g,p1,$1,$3);
					  		addRel(*g,p2,0,$2);
						}
						else
							fprintf(stderr,"A primeira pessoa tem de ser do sexo feminino\n");
					  }
                                         }


	;

Pessoa  : id                   {$$=$1;}
        | '('Membro')'         {$$=$2;}
	;

Membro  : NOME id idFam id  {$$ = $2; 
                                p1 = lookup(*g,$2);
			        if((*g)->tab[p1].status != OCUPADO)
			     		addNode(g,p1,$1,$2,$3,$4[0]);
				else{
					printf("A pessoa que está a inserir já existe deseja atualizar os seus dados?(s/n)\n");
					if(getchar() == 's')
                                        	overwrite(*g,p1,$1,$3,$4[0]);
					fflush(stdin);	
				}
                               }

        ;	
idFam   : '('id')'                 {$$=$2;}
        ;
Evento	: Pessoa '*' DATA          {p1 = lookup(*g,$1);
				    printf("%d\n",$3);
			            if((*g)->tab[p1].status==OCUPADO){
                                    	if(((*g)->tab[p1].morte == 0) || $3 <= (*g)->tab[p1].morte){
						if((*g)->tab[p1].nascimento != 0){
							printf("Esta pessoa já tem uma data de nascimento, pretende alterá-la?(s/n)\n");
							if(getchar() == 's')
                                    				addN(*g,p1,$3);
							fflush(stdin);
						}
						else 
							addN(*g,p1,$3);
				    	}
				    	else{
						fprintf(stderr,"A data de nascimento deve ser menor do que a data de morte\n");
						printP(*g,p1);
				    	}
				    }
				    else
				    	fprintf(stderr,"Esta pessoa não existe no grafo\n");
				   }

	| Pessoa '+' DATA          {p1 = lookup(*g,$1);
			            if((*g)->tab[p1].status==OCUPADO){
                                    	if($3 >= (*g)->tab[p1].nascimento){
						if((*g)->tab[p1].morte != 0){
							printf("Esta pessoa já tem uma data de morte, pretende alterá-la?(s/n)\n");
							if(getchar() == 's')
                                    				addM(*g,p1,$3);
							fflush(stdin);
						}
						else 
							addM(*g,p1,$3);
				    	}
				    	else{
						fprintf(stderr,"A data de morte deve ser maior do que a data da nascimento\n");
						printP(*g,p1);
				    	}
				    }
				    else
				    	fprintf(stderr,"Esta pessoa não existe no grafo\n");
				   }

	| Casamento
	;

Casamento : Pessoa '-' Pessoa DATA {p1 = lookup(*g,$1);				               
                                    p2 = lookup(*g,$3);
			            if((*g)->tab[p1].status==OCUPADO && (*g)->tab[p2].status==OCUPADO){
				    	if($4 >= ((*g)->tab[p1].nascimento) &&(((*g)->tab[p1].morte == 0) || $4 <= (*g)->tab[p1].morte)){
				    		if($4 >= ((*g)->tab[p2].nascimento) &&(((*g)->tab[p2].morte == 0) || $4 <= (*g)->tab[p2].morte)){
				        		 addC(*g,p1,$3,$4);
				                 	addC(*g,p2,$1,$4);

						}
						else{
							fprintf(stderr,"O casamento deve ocorrer durante a vida do 2º conjuge\n");
							printP(*g,p2);
						}
				    	}
				    	else{
				    		fprintf(stderr,"O casamento deve ocorrer durante a vida do 1º conjuge\n");
						printP(*g,p1);
				    	}
				    }
				    else if((*g)->tab[p1].status!=OCUPADO)
                                    	fprintf(stderr,"A primeira pessoa não existe no grafo\n");
				    else
                                    	fprintf(stderr,"A segunda pessoa não existe no grafo\n");
 			 	   }
          ;
	
Consulta: IMPRIME               {printG(*g);}
	| IMPRIME 	id      {p1 = lookup(*g,$2);printP(*g,p1);}
	| IMPRIME	idFam	{printF(*g,$2);}
        ;	
%%

void yyerror(char *s){
	fprintf(stderr, "%s\n", s);
}

int main(){
	yyparse();
	return 0;
}
