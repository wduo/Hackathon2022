#!/bin/bash

set -x
set -e


# encoder
python /target/pre.py
/workspace/tensorrt/bin/trtexec --onnx=/workspace/encoder_new.onnx \
 --saveEngine=/target/encoder.plan \
 --minShapes=speech:1x1x80,speech_lengths:1 \
 --optShapes=speech:16x64x80,speech_lengths:16 \
 --maxShapes=speech:32x256x80,speech_lengths:32 \
 --workspace=8192 \
 --device=1

 
#decoder
/workspace/tensorrt/bin/trtexec --onnx=/workspace/decoder.onnx \
 --saveEngine=/target/decoder.plan \
 --minShapes=encoder_out:1x1x256,encoder_out_lens:1,hyps_pad_sos_eos:1x10x64,hyps_lens_sos:1x10,ctc_score:1x10 \
 --optShapes=encoder_out:16x16x256,encoder_out_lens:16,hyps_pad_sos_eos:16x10x64,hyps_lens_sos:16x10,ctc_score:16x10 \
 --maxShapes=encoder_out:32x64x256,encoder_out_lens:32,hyps_pad_sos_eos:32x10x64,hyps_lens_sos:32x10,ctc_score:32x10 \
 --workspace=8192 \
 --device=1

