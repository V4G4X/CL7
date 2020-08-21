#include <bits/stdc++.h>
using namespace std;

int powermod(int a, int b, int n)
{
	//Ideally a^b%n
	int out = 1;
	a = a % n;
	if (a == 0)
		return 0;
	while (b > 0)
	{
		if (b & 1)
			out = (out * a) % n;
		a = (a * a) % n;
		b >>= 1;
	}
	return out;
}

int main(int argc, char const *argv[])
{
	//    1. Choose two prime numbers p and q.
	int p = 7;
	int q = 11;
	//    2. Compute n = p*q.
	int n = p * q;
	//    3. Calculate phi = (p-1) * (q-1).
	int phi = (p - 1) * (q - 1);
	//    4. Choose an integer e such that 1 < e < phi(n) and gcd(e, phi(n)) = 1; i.e., e and phi(n) are coprime.
	int e;
	for (e = 2; e < phi && __gcd(e, phi) != 1; ++e);
	//    5. Calculate d as d ≡ e−1 (mod phi(n)); here, d is the modular multiplicative inverse of e modulo phi(n).
	int d;
	for (d = 2; e * d % phi != 1; ++d);
	//    6.  Get the plaintext to excrypt
	int plaintext = 72;
	//    7. ciphertext = plaintext^e mod n
	int ciphertext = powermod(plaintext, e, n);
	//	  8. decipheredtext = ciphertext^d mod n
	int decipheredtext = powermod(ciphertext, d, n);

	//Printing States
	cout << "p: " << p << endl;
	cout << "q: " << q << endl;
	cout << "n: " << n << endl;
	cout << "phi: " << phi << endl;
	cout << "e: " << e << endl;
	cout << "d: " << d << endl;
	cout << "Plain Text: " << plaintext << endl;
	cout << "Cipher Text: " << ciphertext << endl;
	cout << "DeCiphered Text: " << decipheredtext << endl;
	return 0;
}
