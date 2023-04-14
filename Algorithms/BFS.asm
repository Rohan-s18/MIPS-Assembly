# assume the graph is stored as an adjacency list
# s0 = pointer to the adjacency list
# s1 = number of nodes in the graph
# s2 = starting node

# initialize queue and visited array
addi $sp, $sp, -4 * $s1
addi $t0, $sp, 0
addi $t1, $sp, 4 * ($s1 - 1)
sw $s2, ($t0)     # enqueue the starting node
addi $t2, $s1, 0
sb $zero, visited($t2)   # set all nodes as unvisited

# perform BFS
loop:
  lw $t3, ($t0)   # dequeue a node from the queue
  addi $t0, $t0, 4
  beq $t3, $zero, done   # if the queue is empty, we're done
  sb $t1, visited($t3)   # mark the node as visited

  # visit each neighbor of the current node
  lw $t4, ($t3)   # load pointer to first neighbor
  neighbor_loop:
    beq $t4, $zero, end_neighbor_loop  # if there are no more neighbors, go to the next node in the queue
    lw $t5, 0($t4)   # load neighbor node
    beq $t5, $zero, end_neighbor_loop  # if the neighbor node is invalid, skip it
    lb $t6, visited($t5)
    bne $t6, $zero, end_neighbor_loop  # if the neighbor node has already been visited, skip it
    addi $t1, $t1, 1   # increment tail of queue
    sw $t5, ($t1)   # enqueue the neighbor node
    sb $t1, visited($t5)   # mark the neighbor node as visited
    end_neighbor_loop:
      addi $t4, $t4, 4   # move to the next neighbor
      j neighbor_loop

  j loop   # process the next node in the queue

done:
  # cleanup
  addi $sp, $sp, 4 * $s1

