import cv2
import sys
import json

cascPath = sys.argv[1]
faceCascade = cv2.CascadeClassifier(cascPath)

video_capture = cv2.VideoCapture(0)

while True:
    # Capture frame-by-frame
    ret, frame = video_capture.read()

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    faces = faceCascade.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(30, 30),
        flags=0
    )

    # Draw a rectangle around the faces
    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
	with open(home/gtandrews/Desktop/faceDet2/cartList.json, "r") as json_file:
		bool : isListed = false;
		while (!isListed):
    			for line in json_file:
        			data = json.loads(line)
        			if data == "{"name":"Smoothie"}":
					isListed = true
					break
				else:
			# Add line for object if detected and is not alraedy listed in the file, otherwise continue
			if (!isListed):
				with open(home/gtandrews/Desktop/faceDet2/cartList.json, "a") as json_file:
					json_file.write("{"name":"Smoothie"}".format(json.dumps(new_data)))
			break
    # Display the resulting frame
    cv2.imshow('Video', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything is done, release the capture
video_capture.release()
cv2.destroyAllWindows()

