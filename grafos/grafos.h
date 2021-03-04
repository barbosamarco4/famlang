#define OCUPADO 1
#define APAGADO 2
#define LIVRE   0

typedef struct aresta{
	int rel;
	char *dest;
	struct aresta* prox;
}*LAdj;

typedef struct casamento{
	int data;
	char *dest;
	struct casamento* prox;
}*LAdjC;

typedef struct entry{
	int status;
	char *id;
	char *idFam;
	char *nome;
	char genero;
	int  nascimento;
	int  morte;
	LAdjC casamento;
	LAdj relacoes;
}*THash;

typedef struct grafo{
	int size;
	int used;
	THash tab;
}*Grafo;

int hash(char[], int);
Grafo createG(int);
void resizeG(Grafo*);
int lookup(Grafo,char[]);
void addNode(Grafo *, int, char[], char[], char[], char);    //nome, id, idFam, genero
void overwrite(Grafo g, int, char[],char[],char);            //nome,idFam, genero
void addRel(Grafo, int, int, char[]); //recebe uma relacao e o id do destinatario
void addN(Grafo,int , int);
void addM(Grafo, int, int);
void addC(Grafo, int, char[], int);
void printP(Grafo,int);
void printF(Grafo, char[]);
void printG(Grafo);
