//
//  CommonArithmetic.c
//  SimpleApp
//
//  Created by wuyp on 2017/7/14.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#include "CommonArithmetic.h"

#pragma mark - 倒叙
int reverse(int num) {
    int temp = 0;
    while (num != 0) {
        temp = temp * 10 + num % 10;
        num /= 10;
    }
    
    return temp;
}

#pragma mark - 链表
typedef struct student {
    int num;
    struct student *next;
} STU;

STU *mergeStuList(STU *stu1, STU *stu2) {
    STU *p1 = stu1;
    STU *p2 = stu2;
    STU *result = (STU *)malloc(sizeof(STU));
    
    while (p1 != NULL || p2 != NULL) {
        if (p1 == NULL) {
            result->next = p2;
            p2 = p2->next;
        } else if (p2 == NULL) {
            result->next = p1;
            p1 = p1->next;
        } else {
            result->next = p1->num > p2->num ? p1 : p2;
            p1 = p1->next;
            p2 = p2->next;
        }
    }
    
    result->next = NULL;
    return result;
}

int *quickSort(int *arr) {
    
    return arr;
}
