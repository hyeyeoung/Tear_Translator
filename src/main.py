'''

ai 서비스 백엔드 파이썬

'''
from flask import Flask, request, url_for,Response, redirect, jsonify,render_template
from model.model import *
from flask_cors import CORS
import os
# -----------------------------------------
app = Flask(__name__)
CORS(app)
LOCATION = "src/audio/"
ALLOWED_EXTENSIONS = {'mp3', 'WAV', 'wav', 'MP3'}
# -----------------------------------------
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/')
def test():
    return render_template('test.html')
        

@app.route('/upload', methods=['GET','POST'])
def upload():
    try:
        if request.method == 'POST':
            file = request.files['audioFile']
            if file and allowed_file(file.filename):
                path = os.path.join(LOCATION + file.filename)
                file.save(path)
                X_new = predict_data(path)
                prediction = model.predict(X_new)
                predicted_class = np.argmax(prediction)
                print(type(predicted_class))
                print(classes[predicted_class])
                dic_t = { 'result' : classes[predicted_class]}
                return jsonify(dic_t)
        return "error"
    except Exception as e:
        print(e)
        return 'error'



# ————————————————————
if __name__ == '__main__':
    app.run('0.0.0.0', port= 8000, debug=True)