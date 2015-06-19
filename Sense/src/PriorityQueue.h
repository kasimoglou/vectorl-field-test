#ifndef PRIORITYQUEUE_H
#define PRIORITYQUEUE_H

#define MAX 1000

struct event_node {
	void (*event_handler)(int, ...);
	uint32_t priority;
	uint8_t order;
};

struct priority_queue {
	struct event_node nodes[MAX];
	uint8_t front;
	uint8_t rear;
};

void initialize(struct priority_queue *pq) {
	pq->front = pq->rear = -1;
}

void add(struct priority_queue *pq, struct event_node event_) {
	struct event_node tmp;
	uint8_t i, j;
	
	
	if (pq->rear >= MAX -1 ) {
		return;
	}
	
	pq->rear++;
	pq->nodes[pq->rear] = event_;
	
	if (pq->front == -1) {
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

struct event_node delete (struct priority_queue *pq) {
	struct event_node t;
	
	if (pq->front == -1) {
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



#endif /* PRIORITYQUEUE_H */
