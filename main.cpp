#include "stdafx.h"
#include <iostream>
#include <math.h>
using namespace std;
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
	void deltree(Node<T>* p);
	T    out(Node<T>* M, Node<T>* N);
	void find(T m, T n);
	void way(Node<T>* p, T n, Node<T>* &q);
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
			R->num = log(i) / log(2);
			R->parent = C;
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
T tree<T>::out(Node<T>* M, Node<T>* N)
{
	if (M->num >= N->num)
	{
		while( M->num != N->num)
			M = M->parent;
	}
	else
	{
		while( N->num != M->num)
			N = N->parent;
	}

	while (M->data != N->data)
	{
		M = M->parent;
		N = N->parent;
	}
	return M->data;
}
template<class T>
void tree<T>::find(T m, T n)
{
	T s;
	Node<T>* N1 = new Node<T>;
	Node<T>* N2 = new Node<T>;
	way(root, m, N1);
	way(root, n, N2);
	s = out(N1, N2);
	cout << "公共祖先为：" << s << endl;
}
template<class T>
void tree<T>::way(Node<T>* p, T n, Node<T>* &q)
{

	if (p->data == n)
	{
		q = p;
	}
	else
	{
		if (p->lch != NULL) way(p->lch, n, q);
		if (p->rch != NULL) way(p->rch, n, q);
	}
}

void main()
{
	const int N = 80;
	int n = -1;
	char x, mm, nn;
	char a[N];
	cout << "输入字符(X表示空)：" << endl;
	cin >> a;
	while (a[++n] != NULL);   //n为字符数
	tree<char> A(a, n);
	cout << "输入要查询的字符：" << endl;
	cin >> mm >> nn;
	A.find(mm, nn);
}