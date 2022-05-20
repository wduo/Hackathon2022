# trt2022


# run

```shell
sudo docker run -it --rm --gpus all --name trt2022 \
  -v /data/wd/repos/Hackathon2022:/target registry.cn-hangzhou.aliyuncs.com/trt2022/dev bash

```

```shell
chmod +x /target/build.sh
/target/build.sh

python /workspace/testEncoderAndDecoder.py

```

