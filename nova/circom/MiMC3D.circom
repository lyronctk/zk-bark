pragma circom 2.1.1;

include "./utils/utils.circom";

template MiMC3D(H, W, D) {
    signal input arr[H][W][D];
    signal output h;

    h <== MimcHashMatrix3D(H, W, D)(arr);
    log(h);
}

component main { public [ arr ] } = MiMC3D(28, 28, 4);