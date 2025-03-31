#include "golden_model_c.h"

// Encoding function
int encode(int data) {
    if (data & 0x8) return 3; // data[3]
    if (data & 0x4) return 2; // data[2]
    if (data & 0x2) return 1; // data[1]
    if (data & 0x1) return 0; // data[0]
    return 0;
}

// Golden model function called from SystemVerilog
extern "C" void golden_model_f(int D, int *Q, int *valid) {
    *Q = encode(D);
    *valid = (D != 0);
}