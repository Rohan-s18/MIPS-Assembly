# assume the graph is stored as an adjacency list
# s0 = pointer to the adjacency list
# s1 = number of nodes in the graph
# s2 = starting node

# initialize visited array
addi $sp, $sp, 4 * $s1
addi $t0, $sp, 0
addi $t1, $s1, 0
sb $zero, visited($t1)   # set all nodes as unvisited

# perform DFS
dfs:
  lb $t2, visited($s2)
  bne $t2, $zero, done   # if the node has already been visited, skip it
  sb $t1, visited($s2)   # mark the node as visited
  lw $t3, ($s2)   # load pointer to first neighbor
  neighbor_loop:
    beq $t3, $zero, end_neighbor_loop  # if there are no more neighbors, backtrack
    lw $t4, 0($t3)   # load neighbor node
    beq $t4, $zero, end_neighbor_loop  # if the neighbor node is invalid, skip it
    j dfs   # visit the neighbor recursively
    end_neighbor_loop:
      addi $t3, $t3, 4   # move to the next neighbor
      j neighbor_loop

  done:
    # backtrack
    jr $ra

# cleanup
addi $sp, $sp, -4

