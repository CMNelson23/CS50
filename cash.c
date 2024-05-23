#include <cs50.h>
#include <stdio.h>

int get_change(void);
int calc_quarter(int change);
int calc_dime(int change);
int calc_nickel(int change);
int calc_penny(int change);

int main(void)
{
    int change = get_change();

    int quarter = calc_quarter(change);
    change = change - quarter * 25;

    int dime = calc_dime(change);
    change = change - dime * 10;

    int nickel = calc_nickel(change);
    change = change - nickel * 5;

    int penny = calc_penny(change);
    change = change - penny;

    int coins = quarter + dime + nickel + penny;

    printf("%i\n", coins);
}

int get_change(void)
{
    int change;
    do
    {
        change = get_int("Change owed?: ");
    }
    while (change < 0);
    return change;
}

int calc_quarter(int change)
{
    int quarter = 0;
    while (change >= 25)
    {
        change = change - 25;
        quarter++;
    }
    return quarter;
}

int calc_dime(int change)
{
    int dime = 0;
    while (change >= 10)
    {
        change = change - 10;
        dime++;
    }
    return dime;
}

int calc_nickel(int change)
{
    int nickel = 0;
    while (change >= 5)
    {
        change = change - 5;
        nickel++;
    }
    return nickel;
}

int calc_penny(int change)
{
    int penny = 0;
    while (change >= 1)
    {
        change = change - 1;
        penny++;
    }
    return penny;
}
