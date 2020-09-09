#include "../drivers/ports.h"

void write_string(int colour, const char *string);

void kmain()
{
    // So basically this is how we use the driver for VGA.
    // We first set the vga control register to 14, meaning we're asking for byte 14,
    // which is the byte where the high byte of the cursor is stored. We read in the result,
    // and bit shift it so we move it to the higher position (since it is the higher byte)

    port_byte_out(0x3d4, 14);
    int position = port_byte_in(0x3d5);
    position = position << 8;

    // Now, we read in the lower byte, and add it to position. Position will then have the full location of the cursor

    port_byte_out(0x3d4, 15);
    position += port_byte_in(0x3d5);

    // We multiply our offset by two since we want to skip the color bytes
    int offset = position * 2;

    // We then use the vga location in memory, and write our data to it after adding our offset.
    // This will print our text at the cursor instead of the top left/
    char *vga = 0xb8000;
    vga[offset] = 'X';
    vga[offset + 1] = 0x0f;

}

// Our print string we wrote before. Needs to be update to write at cursor.
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