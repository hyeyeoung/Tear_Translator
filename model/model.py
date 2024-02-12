import librosa
import numpy as np
from tensorflow.image import resize
from tensorflow.keras.models import load_model

model = load_model('./complete_model.h5') # 파일 경로에 한글이 있으면 안됨

classes = ['belly_pain','burping','discomfort','hungry','tired']

# 음성 파일 불러오기
def predict_data(path, target_shape=(128, 128)):
    audio_data, sample_rate = librosa.load(path, sr=None)
    mel_spectrogram = librosa.feature.melspectrogram(y=audio_data, sr=sample_rate)
    mel_spectrogram = resize(np.expand_dims(mel_spectrogram, axis=-1), target_shape)
    return np.array([mel_spectrogram])

#샘플 데이터 경로
path = "./dataset/belly_pain/69BDA5D6-0276-4462-9BF7-951799563728-1436936185-1.1-m-26-bp.wav"
X_new = predict_data(path)

# 새로운 데이터에 대한 예측 수행
prediction = model.predict(X_new)

predicted_class = np.argmax(prediction)

# 예측값 출력
print(f"예측된 클래스 = {classes[predicted_class]}")