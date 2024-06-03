#include <cs50.h>
#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
    // Prompt User for some text
    string text = get_string("Text: ");

    // Count the number of letters, words, and sentances in the text
    int letters = 0;
    int words = 1;
    int sentances = 0;

    // Compute the index
    for (int i = 0; i < strlen(text); i++)
    {
        if (isalpha(text[i]))
        {
            letters++;
        }
        else if (text[i] == ' ')
        {
            words++;
        }
        else if (text[i] == '.' || text[i] == '?' || text[i] == '!')
        {
            sentances++;
        }
    }

    float L = (float) letters / (float) words * 100;
    float S = (float) sentances / (float) words * 100;

    int index = round(0.0588 * L - 0.296 * S - 15.8);

    // Print Grade level
    if (index < 1)
    {
        printf("Before Grade 1\n");
    }

    else if (index > 16)
    {
        printf("Grade 16+\n");
    }

    else
    {
        printf("Grade %i\n", index);
    }
}
