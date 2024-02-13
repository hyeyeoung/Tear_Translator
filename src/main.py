'''

ai 서비스 백엔드 파이썬

'''
from flask import Flask, request, url_for,Response, redirect, jsonify
from model.model import *
import os
# -----------------------------------------
app = Flask(__name__)
LOCATION = "./audio/"
ALLOWED_EXTENSIONS = {'mp3', 'WAV', 'wav', 'MP3'}
# -----------------------------------------
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/upload', methods=['POST'])
def upload():
    try:
        if request.files['file'] == '':
            print("다시 업로드 해주세요")
            return redirect(url_for(''))
        file = request.files['file']
        if file and allowed_file(file.filename):
            path = os.path.join(LOCATION + file.filename)
            file.save(path)
            X_new = predict_data(path)
            prediction = model.predict(X_new)
            top_classes_indices = np.argsort(prediction)[::-1][:3]
            result_dict = {"top_classes": []}
            for i, class_index in enumerate(top_classes_indices):
                class_info = {
                    "rank": i+1,
                    "class_name": classes[class_index],
                    "probability": float(prediction[class_index])
                }
                result_dict["top_classes"].append(class_info)

            return jsonify(result_dict)
        return "g.."
    except Exception as e:
        print(e)
        return 'error'



# -----------------------------------------
if __name__ == '__main__':
    app.run('0.0.0.0', port= 8000, debug=True)