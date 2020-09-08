void write_string(int colour, const char *string);

void proof_that_it_actually_calls_kmain_and_not_the_first_function_it_finds()
{
}

void kmain()
{
    // Just be happy with writing X at the top left corner lel
    // char *video_memory = (char *)0xb8000;
    // *video_memory = 'X';
    write_string(0x07, "Hello, world!");
}

void write_string(int colour, const char *string)
{
    char *video = (char *)0xb8000;
    while (*string != 0)
    {
        *video++ = *string++;
        *video++ = colour;
    }
    return;
}