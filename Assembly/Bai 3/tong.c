/*#include<stdio.h>
#include <string.h>

int main(){
    int sodu=0, k=0;
    char A[255],B[255],C[255];

    scanf("%s%s",&A,&B);
    int S1= strlen(A)-1;
    int S2= strlen(B)-1;

    while(S1>=0||S2>=0||sodu>0)
    {
        int a= S1>=0?A[S1]-'0':0;
        int b= S2>=0?B[S2]-'0':0;
        int s= a+b+sodu;
        C[k]=s%10;
        sodu = s/10 + '0';
        S1--;
        S2--;
        k++;
    }
    C[k] = '\0';
    for(int i=k-1;i>=0;i--)
    {
        printf("%s",C[i]);
    }
}*/
#include <stdio.h>
#include <string.h>

int main() {
  char A[255];
  char B[255];

  scanf("%s%s", A, B);

  int S1 = strlen(A) - 1;
  int S2 = strlen(B) - 1;

  int carry = 0;
  char C[255];
  int k = 0;
  while (S1 >= 0 || S2 >= 0 || carry > 0) {
    int a = S1 >= 0 ? A[S1] - '0' : 0;
    int b = S2 >= 0 ? B[S2] - '0' : 0;
    int s = a + b + carry;
    C[k] = s % 10 + '0';
    carry = s / 10;
    S1--;
    S2--;
    k++;
  }
  

  for (int i = k - 1; i >= 0; i--) {
    printf("%c", C[i]);
  }

  return 0;
}