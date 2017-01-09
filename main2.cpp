
#include<iostream>
using namespace std;

char z;
int c=20;
int n = 0;

template<class T>
struct Node
{
	T data;
	int num;
	Node<T>* parent;
	Node<T>* lch;
	Node<T>* rch;
};
template<class T>
struct tree
{
public:
	tree(T a[], int n);
	void build(Node<T>* &R, Node<T>* &C, T a[], int i, int n);
	void readb(Node<T>* p,T a,T b);

	Node<T>* root;
};

template<class  T>
void tree<T>::build(Node<T>* &R, Node<T>* &C, T a[], int i, int n)
{
	if (i <= n)
	{
		R = new Node<T>;
		if (a[i - 1] == 'X')
			R = NULL;
		else
		{
			R->data = a[i - 1];
			R->parent = C;
			R->num = log(i) / log(2);
			build(R->lch, R, a, 2 * i, n);
			build(R->rch, R, a, 2 * i + 1, n);
		}
	}
	else R = NULL;
}
template<class T>
tree<T>::tree(T a[], int n)
{
	build(root, root, a, 1, n);
}

template<class T>
void tree<T>::readb(Node<T>* p,T a,T b)
{
	if (p != NULL)
	{
		readb(p->lch, a, b);
		readb(p->rch, a, b);
		if (p->data == a || p->data == b)
			n++;
		if (n == 1)
		if (p->parent->num < c)
		{
			z = p->parent->data;
			c = p->parent->num;
		}
	}
}

void main()
{
	const int N = 80;
	int n = -1;
	char a[N];
	char i, j;
	cout << "输入字符：" ;
	cin >> a;
	while (a[++n] != NULL);
	tree<char> A(a, n);
	cout << "输入要查询字符：" ;
	cin >> i >> j;
	A.readb(A.root, i, j);
	cout << "查询结果为：" << z << endl;
}