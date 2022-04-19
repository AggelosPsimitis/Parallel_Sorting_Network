#### Final exercise for parallel and distributed systems class of electronic automation post-graduate program (NKUA).
- 3x4 Mesh network for sorting four 3-bit numbers in parallel.
- The mesh consists of 12 PEs (Processing Elements).
- Each PE performs 1-bit comparisons and stores/forwards 1-bit signal values to it's right/down PEs along with proper flag signals.
- The 3-bit words are received in parallel and are fed sequentially to each network row in a pipelined fashion.
- Top row receives the MSB.
- Last row receives the LSB after 2 clock cycles (bit-steps).
- After 2*N + k - 2 bit-steps (N is # of words, k is # of bits in each word) the network has stored the numbers in ascending order.  
