pragma circom 2.1.1;
include "./Backbone.circom";

template Backbone3(nRows, nCols, nChannels, nFilters, kernelSize, strides, padding) {
    var paddedRows = nRows + padding * 2;
    var paddedCols = nCols + padding * 2;

    signal input step_in[2];
    signal input a_prev_1[paddedRows][paddedCols][nChannels];
    signal input W_1[kernelSize][kernelSize][nChannels][nFilters];
    signal input b_1[nFilters];
    signal input a_prev_2[paddedRows][paddedCols][nChannels];
    signal input W_2[kernelSize][kernelSize][nChannels][nFilters];
    signal input b_2[nFilters];
    signal input a_prev_3[paddedRows][paddedCols][nChannels];
    signal input W_3[kernelSize][kernelSize][nChannels][nFilters];
    signal input b_3[nFilters];
    signal output step_out[2];

    component first_layer = Backbone(28, 28, 2, 2, 3, 1, 1);
    first_layer.step_in <== step_in;
    first_layer.a_prev <== a_prev_1;
    first_layer.W <== W_1;
    first_layer.b <== b_1;

    component second_layer = Backbone(28, 28, 2, 2, 3, 1, 1);
    second_layer.step_in <== first_layer.step_out;
    second_layer.a_prev <== a_prev_2;
    second_layer.W <== W_2;
    second_layer.b <== b_2;

    component third_layer = Backbone(28, 28, 2, 2, 3, 1, 1);
    third_layer.step_in <== second_layer.step_out;
    third_layer.a_prev <== a_prev_3;
    third_layer.W <== W_3;
    third_layer.b <== b_3;

    step_out <== third_layer.step_out;
}

component main { public [step_in] } = Backbone3(28, 28, 2, 2, 3, 1, 1);