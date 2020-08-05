# Assembly Fun
Recently, I looked at [@geohot](https://github.com/geohot)'s video of adding fore loops to Clang.

I really wanted to learn more about Clang and LLVM, so I looked into it.

On a whim, I thought "Hmm... let's make our own basic OS from scratch."

And I did. I tried atleast.

This is still a WIP project, and I'm still learning.

`latest` contains the latest code I've written, and the other folders contain older code that I wrote while learning.

I've used `bochs` for testing, `nasm` for compiling my Assembly code. The `.bin` files are the compiled machine code.

All code is for the original x86 architecture.

The `./latest/bochsrc` contains the config for the latest OS image. You'll have to modify it for every subfolder to run each image. Maybe I'll automate this config generation, compilation and testing later.