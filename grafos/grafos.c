#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "grafos.h"

#define PAI   0
#define MAE   1
#define AVOM  2
#define AVOP  3
#define AVM   4
#define AVP   5
#define FILHO 6

int hash(char* id, int size){
	int s,i;
	s=0;
	for(i=0;id[i]!='\0';s += id[i++]);
	return s%size;
}
Grafo createG(int size){ //cria um grafo com tamanho "size"
	int i;
	Grafo r;
	r = malloc(sizeof(struct grafo));
	r->used = 0;
	r->size = size;
	r->tab =  malloc(sizeof(struct entry)*size);
	for(i=0;i<size;(r->tab[i++]).status = LIVRE);
	return r;
}

void resizeG(Grafo *g){ //recebe um grafo e o seu tamanho e retorna um grafo com os mesmos elementos e o dobro do tamanho
	int i,p;
	Grafo new = createG((*g)->size*2);
	for(i=0;i<(*g)->size;i++){
		if((*g)->tab[i].status == OCUPADO){
			p = hash((*g)->tab[i].id,(*g)->size*2);
			while(new->tab[p].status == OCUPADO)
				p++;
			new->tab[p].status = OCUPADO;
			new->tab[p].id = strdup((*g)->tab[i].id);
			new->tab[p].nome = strdup((*g)->tab[i].nome);
			new->tab[p].genero = (*g)->tab[i].genero;
			new->tab[p].relacoes = (*g)->tab[i].relacoes;
		}
	}
	new->used = (*g) -> used;
	free((*g)->tab);
	free((*g));
	*g = new;
}

int lookup(Grafo g, char* id){
	int p;
	p = hash(id,g->size);
	while(g->tab[p].status != LIVRE && strcmp(g->tab[p].id,id))
		p++;
	return p;
}

void  addNode(Grafo *g,int p,char *nome, char *id, char *idFam, char genero){ //adiciona um nodo ao grafo, inserindo esse elemento na tabela de hash 
	if((*g)->size <= (*g)->used*2){ //fator de carga maior que 0.5
        	resizeG(g);  //duplica o tamanho do grafo
		p = lookup(*g,id);
	}
	(*g)->tab[p].status = OCUPADO;
	(*g)->tab[p].id = strdup(id);
	(*g)->tab[p].idFam = strdup(idFam);
	(*g)->tab[p].nome = strdup(nome);
	(*g)->tab[p].genero = genero;
	(*g)->tab[p].nascimento = 0;
	(*g)->tab[p].morte = 0;
	(*g)->tab[p].relacoes = NULL;
	(*g)->tab[p].casamento = NULL;
	(*g)->used++;
}


void overwrite(Grafo g, int p, char *nome, char *idFam, char genero){
        free(g->tab[p].idFam);
        free(g->tab[p].nome);
	g->tab[p].genero = genero;
	g->tab[p].idFam = strdup(idFam);
	g->tab[p].nome = strdup(nome);
}

void addRel(Grafo g,int p, int rel, char *t){ //hash de s e adiciona a relacao com t, hash de t e adiciona relacao com s
	LAdj tmp;
	tmp = malloc(sizeof(struct aresta));
	tmp->rel = rel;
	tmp->dest=strdup(t);
	tmp->prox = g->tab[p].relacoes;
	g->tab[p].relacoes = tmp;
}

//adiciona a data do nascimento
void addN(Grafo g,int p, int n){
	g->tab[p].nascimento = n;
}

//adiciona a data da morte
void addM(Grafo g,int p, int m){
	g->tab[p].morte = m;
}

//adiciona um casamento
void addC(Grafo g,int p, char *t, int d){
	LAdjC tmp;
	tmp = malloc(sizeof(struct casamento));
	tmp->data=d;
	tmp->dest=strdup(t);
	tmp->prox = g->tab[p].casamento;
	g->tab[p].casamento = tmp;
}

void printRel(int rel){
	if(rel == 259){
		printf("Mãe");
	}
	else if(rel == 258){
		printf("Pai");
	}

	else if(rel == 260){
		printf("AvoM");
	}

	else if(rel == 261){
		printf("AvoP");
	}

	else if(rel == 262){
		printf("AvóM");
	}

	else if(rel == 263){
		printf("AvóP");
	}

	else if(rel == 264){
		printf("Filho");
	}
	else{
		printf("Neto");
	}
	printf("\n");
}

void printDate(int data){
	int d,m,y;
	if(data!=0){
		y = data/10000;
		data = data % 10000;
		m = data / 100;
		d = data % 100;
		printf("%d/%d/%d\n",d,m,y);
	}
	else
		printf("\n");
}

void printP(Grafo g,int p){
	LAdj t;
	LAdjC tmp;
	printf("Nome: %s\n",g->tab[p].nome);
	printf("id: %s\n",g->tab[p].id);
	printf("idFam: %s\n",g->tab[p].idFam);
	printf("genero: %c\n",g->tab[p].genero);
	printf("Nascimento:");
	printDate(g->tab[p].nascimento);
	printf("Morte:");
	printDate(g->tab[p].morte);
	t = g->tab[p].relacoes;
	while(t!=NULL){
		printRel(t->rel);
		printf("Pessoa: %s\n",t->dest);
		t = t->prox;
	}
	tmp = g->tab[p].casamento;
	while(tmp != NULL){
		printf("Casamento\n");
		printf("%s\n",tmp->dest);
		printDate(tmp->data);
		tmp = tmp-> prox;
	}
	printf("----------\n");
}

void printF (Grafo g, char *sF){
	int i;
	int sizeF =1;
	for(i=0;i<g->size;i++){
		if(g->tab[i].status == OCUPADO && strcmp(sF,g->tab[i].idFam) == 0){
			sizeF ++;
			printP(g,i);
		}
	}
	printf("%d\n",sizeF);
}

void printG(Grafo g){
	int i;
	for(i=0;i<g->size;i++){
		if(g->tab[i].status == OCUPADO){
			printP(g,i);
		}
	}
}

