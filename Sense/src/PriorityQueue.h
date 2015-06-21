#ifndef PRIORITYQUEUE_H
#define PRIORITYQUEUE_H

#define MAX 1000
#include<stdio.h>

uint8_t event_counter = 0;

typedef   void (*Action)();

struct event_node {
	uint32_t priority;
	uint8_t order;
	Action event_handler;
};

struct priority_queue {
	struct event_node nodes[MAX];
	uint8_t front;
	uint8_t rear;
};

struct priority_queue event_queue;

void initialize(struct priority_queue *pq) {
	pq->front = pq->rear = -1;
}

void add(struct priority_queue *pq, Action event_handler, uint32_t priority, uint8_t order) {
	
	struct event_node event_;
	struct event_node tmp;
	uint8_t i, j;

	event_.event_handler = event_handler;
	event_.priority = priority;
	event_.order = order;
	
	if (pq->rear >= MAX -1 ) {
		return;
	}
	
	pq->rear++;
	pq->nodes[pq->rear] = event_;
	
	if (pq->front == (uint8_t)-1) {
		pq->front = 0;
	}
	
	for (i = pq->front; i <= pq->rear; i++) {
		for (j = i + 1; j <=pq->rear; j++) {
			if (pq->nodes[i].priority > pq->nodes[j].priority) {
				tmp = pq->nodes[i];
				pq->nodes[i] = pq->nodes[j];
				pq->nodes[j] = tmp;
			} else {
				if (pq->nodes[i].priority == pq->nodes[j].priority) {
					if (pq->nodes[i].order > pq->nodes[j].order) {
						tmp = pq->nodes[i];
						pq->nodes[i] = pq->nodes[j];
						pq->nodes[j] = tmp;
					}
				}
			}
		}
	}
	
}

struct event_node delete(struct priority_queue *pq) {
	struct event_node t;
	
	if (pq->front == -1) {
		printf("Error! Queue is empry");
		return t;
	}
	
	
	t = pq->nodes[pq->front];
	pq->nodes[pq->front] = t;
	if (pq->front == pq->rear) {
		pq-> front = pq->rear = -1;
	} else {
		pq->front++;
	}
	
	return t;
}

bool isEmpty(struct priority_queue *pq) {
	return (pq->front == (uint8_t)-1);
}



#endif /* PRIORITYQUEUE_H */
