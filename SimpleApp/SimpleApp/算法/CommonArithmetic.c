//
//  CommonArithmetic.c
//  SimpleApp
//
//  Created by wuyp on 2017/7/14.
//  Copyright © 2017年 wuyp. All rights reserved.
//

#include "CommonArithmetic.h"

static int linkListCount = 10;

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
    struct student *prior; //before
    struct student *next;  //next
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

#pragma mark - 单向链表

STU *singleLinkList() {
    STU *head, *tail, *temp;
    head = tail = temp = NULL;
    
    head = (STU *)calloc(1, sizeof(STU));
    if (head == NULL) {
        perror("malloc error");
        return NULL;
    }
    
    int i = 0;
    
    do {
        temp = (STU *)calloc(1, sizeof(STU));
        temp->next = NULL;
        
        if (head->next == NULL) {
            head->num = i;
            head->next = temp;
            tail = temp;
        } else {
            tail->next = temp;
            tail = temp;
        }
        
        tail->num = ++i;
        
    } while (i + 1 < linkListCount);
    
    return head;
}

#pragma mark - 双向链表

STU *bothWayLinkList() {
    STU *head, *tail, *temp;
    head = tail = temp = NULL;
    
    head = (STU *)calloc(1, sizeof(STU));
    if (head == NULL) {
        perror("malloc error");
        return NULL;
    }
    
    int i = 0;
    do {
        temp = calloc(1, sizeof(STU));
        temp->prior = tail;
        temp->next = NULL;
        
        if (head->next == NULL) {
            tail = temp;
            head->num = i;
            head->prior = NULL;
            head->next = tail;
            tail->prior = head;
        } else {
            tail->next = temp;
            tail = temp;
        }
        
        tail->num = i++;
        
    } while (i + 1 < linkListCount);
    
    return head;
}

#pragma mark - 循环链表

STU *circleLinkList() {
    STU *head, *tail, *temp;
    head = tail = temp = NULL;
    
    head = (STU *)calloc(1, sizeof(STU));
    if (head == NULL) {
        perror("malloc error");
        return NULL;
    }
    
    int i = 0;
    
    do {
        temp = (STU *)calloc(1, sizeof(STU));
        temp->next = NULL;
        
        if (head->next == NULL) {
            head->num = i;
            head->next = temp;
            tail = temp;
        } else {
            tail->next = temp;
            tail = temp;
        }
        
        tail->num = ++i;
        
    } while (i + 1 < linkListCount);
    
    tail->next = head;
    
    return head;
}
