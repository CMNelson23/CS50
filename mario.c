#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int height, i, j, k;
    do
    {
        height = get_int("Height: ");
    }
    while (height < 1 || height > 8);

    for (i = 0; i < height; i++)
    {
        for (k = 0; k < height - i - 1; k++)
        {
            printf(" ");
        }
        for (j = 0; j <= i; j++)
        {
            printf("#");
        }
        printf("\n");
    }
}
