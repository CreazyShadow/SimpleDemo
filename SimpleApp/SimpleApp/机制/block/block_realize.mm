//
//  block_realize.cpp
//  SimpleApp
//
//  Created by wuyp on 2017/4/19.
//  Copyright © 2017年 wuyp. All rights reserved.
//

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0 *Desc;
    __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int flags = 0) {
        impl.isa = &_NSConcreteStackBlock;
        impl.Flags = flags;
        impl.FuncPtr = fp;
        Desc = desc;
    }
};

static void __attribute__((unused)) __main_block_func_0(struct __main_block_impl_0 *__cself) {
    printf("Hello, World!\n");
}

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA __attribute__((unused))  = {0, sizeof(struct __main_block_impl_0)};

//int main() {
//    (void (*)())(&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA))();
//    return 0;
//}
