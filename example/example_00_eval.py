#!/usr/bin/env python

### Eval option 1: onnxruntime 
import numpy as np 
import onnxruntime as rt

sess = rt.InferenceSession("test.onnx")
input_name = sess.get_inputs()[0].name
img = np.ones((3, 3)).astype(np.float32)
pred_onx = sess.run(None, {input_name: img})[0]
print(pred_onx)

### Eval option 2: PyTorch (Caffe2) 
"""
import numpy as np
import caffe2
import onnx
img = np.ones((3, 3)).astype(np.float32)

model = onnx.load('test.onnx')
outputs = caffe2.python.onnx.backend.run_model(model, [img])
"""

### Expected Output 
"""
[[0.84147096 0.84147096 0.84147096]
 [0.84147096 0.84147096 0.84147096]
 [0.84147096 0.84147096 0.84147096]]
"""