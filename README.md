# ObjectDetection

YOLOv7のトレーニングおよび検証を行うためのリポジトリ

### 推論結果

上記のコードは[公式サイト](https://github.com/WongKinYiu/yolov7)のコードを一部変更してローカル環境で実装しています。

## モデルの検証をローカルで行う方法

ここから先はモデルのトレーニング・テストを自分の環境でやってみたい方向けです。

### 0, 環境

---
- Python: 3.10.11
- CUDA: 11.8
- PyTorch: 1.12.0+cu118
---

### 1, セットアップ

ターミナルを開きこのリポジトリをクローンしてエディターを開きます。

```sh
git clone https://github.com/TechC-SugarCane/ObjectDetection

cd ObjectDetection

code .
```

事前学習済みモデル(`yolov7-d6`)を以下のリンクからダウンロードします。新しく`checkpoints`のフォルダーを作成して、その中に格納するようにします。<br>
[事前学習済みモデルはこちら](https://github.com/WongKinYiu/yolov7/releases/download/v0.1/yolov7-d6.pt)

データセットは 一階層上に[manage-datasetリポジトリ](https://github.com/TechC-SugarCane/manage-dataset)をcloneし、[manage-dataset/README](https://github.com/TechC-SugarCane/manage-dataset/blob/main/README.md)に従ってダウンロードしてください。

```sh
# clone済みの人はスキップ
cd ..
git clone git@github.com:TechC-SugarCane/manage-dataset.git
```

`.venv`のインストールをしてモジュールをインストールします。<br>

```sh
python -m venv .venv

.venv/Scripts/activate

python -m pip install --upgrade pip

pip install -r requirements.txt
```

`CUDA`が使えるのかを確認します。
```py
import torch
torch.cuda.is_available()
```

`False`の結果が返ってきた場合、GPUドライバがインストールされているか確認します。<br>
確認できた、既にインストールがされていた場合、ターミナルで以下のコマンドを入力します。
その際仮想環境にインストールしたtorchは一度アインストールします。

```sh
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu118
```

インストールしたらもう一度`CUDA`が使えるか確認します。

### 2 学習の実行

ターミナルで以下のコマンドを入力し学習を開始します。<br>
`--epochs`で学習を行う回数を指定できます。
学習の回数によってかかる時間は変わってきます。

```sh
# sugarcane
# タスク的にはp5のtrain.pyを使うべきですが、
# train.pyだとエラーが出るので、train_aux.pyを使います
python train_aux.py --workers 8 --batch-size 16 \
  --data ../manage-dataset/datasets/sugarcane/data.yaml \
  --cfg cfg/training/yolov7-d6.yaml \
  --weights checkpoints/yolov7-d6.pt \
  --name yolov7-d6-sugarcane \
  --hyp data/hyp.scratch.sugarcane.yaml \
  --epochs 300 \
  --device 0

# pineapple
python train_aux.py --workers 8 --batch-size 16 \
  --data ../manage-dataset/pineapple/data.yaml \
  --cfg cfg/training/yolov7-d6.yaml \
  --weights checkpoints/yolov7-d6.pt \
  --name yolov7-d6-pineapple \
  --hyp data/hyp.scratch.pineapple.yaml \
  --epochs 300 \
  --device 0
```

### 3 推論を行う

学習が正常に終了したら、以下のコマンドを実装し推論を行います。<br>
結果は`./runs/detect/{自分が指定したフォルダー名}`の中に格納されています

```sh
python detect.py --weights runs/train/yolov7-d6-sugarcane/weights/best.pt \
  --conf 0.25 --img-size 640 \
  --source ../manage-dataset/datasets/sugarcane/test/images \
  --name yolov7-d6-sugarcane-test
```
