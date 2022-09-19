#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
int main()
{
    while (5)
    {
        int x;
        float a, b;
        printf("Enter Your Choice From Given Below Options \n1.Addition\n2.Substraction\n3.Multiplication\n4.Division\n5.Exit\n");
        scanf("%d", &x);
        switch (x)
        {
        case 1:
            printf("Enter two Number\n");
            scanf("%f%f", &a, &b);
            printf("Sum = %f", a + b);
            break;
        case 2:
            printf("Enter two Number\n");
            scanf("%f%f", &a, &b);
            printf("First Number - Second Number = %f", a - b);
            break;
        case 3:
            printf("Enter two Number\n");
            scanf("%f%f", &a, &b);
            printf("Multiplication of both Numbers = %f", a * b);
            break;
        case 4:
            printf("Enter two Number\n");
            scanf("%f%f", &a, &b);
            printf("Divion of First Number by Second Number = %f", a / b);
            break;
        case 5:
            exit(0);
            break;
        default:
            printf("You Have  Not Chosen From Above Options ");
            break;
        }
        printf("\n");
    }
    getch();
}
