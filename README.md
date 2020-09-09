# Assembly Fun
Recently, I looked at [@geohot](https://github.com/geohot)'s video of adding fore loops to Clang.

I really wanted to learn more about Clang and LLVM, so I looked into it.

On a whim, I thought "Hmm... let's make our own basic OS from scratch."

And I did. I tried atleast.

This are the basic steps leading up to a 32-bit OS made entirely from scratch. No Bootloader, no Stivale, and no prior knowledge of C or Assembly needed. I do, however recommend watching some of Ben Eater's videos on YouTube to understand better how programs run at the *really* low level. Like the binary level.

This is still a WIP project, and I'm still learning.

`latest` contains the latest code I've written, and the other folders contain older code that I wrote while learning. After this becomes big enough, it will move to its own repository where it will be a standalone OS.

I used `bochs` for testing inititally, now I use `qemu`, `nasm` for compiling my Assembly code. The `.bin` files are the compiled machine code.

All code is for the original i386 architecture.

Old comment:
> The `./latest/bochsrc` contains the config for the latest OS image. You'll have to modify it for every subfolder to run each image. Maybe I'll automate this config generation, compilation and testing later.

All builds have been moved to `Make`. A Makefile is included in the newer folders. The old ones still use bochs.