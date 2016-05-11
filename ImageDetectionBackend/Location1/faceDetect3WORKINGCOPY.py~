import cv2
import sys
import time
import os

# Each unique object needs its own cascade
cascPath0 = sys.argv[1]
cascPath1 = sys.argv[2]
cascPath2 = sys.argv[3]
#cascPath3 = sys.argv[4]
#cascPath4 = sys.argv[5]
#cascPath5 = sys.argv[6]

#define the cascades
cartCascade0 = cv2.CascadeClassifier(cascPath0)
cartCascade1 = cv2.CascadeClassifier(cascPath1)
cartCascade2 = cv2.CascadeClassifier(cascPath2)

video_capture = cv2.VideoCapture(0)

# Support for last known detection of specific objects
lastKnown0 = True
lastKnown1 = True
lastKnown2 = True
#lastKnown3 = True
#lastKnwon4 = True
#lastKnown5 = True

while True:
    time.sleep(1)
    # Capture frame-by-frame
    ret, frame = video_capture.read()

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

# Use the following when adding support for more detection units (make sure to replace X): 
# cartsX = cartCascadeX.detectMultiScale(
#	 gray,
#        scaleFactor=1.1,
#        minNeighbors=5,
#        minSize=(10, 10),
#        flags=0
#    )

    carts0 = cartCascade0.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(10, 10),
        flags=0
    )

    carts1 = cartCascade1.detectMultiScale(
	gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(10, 10),
        flags=0
    )

    carts2 = cartCascade1.detectMultiScale(
	gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(10, 10),
        flags=0
    )
    
    # Draw a rectangle around the objects
    # Check last known for is at location and determine if the JSON should be updated, this will
    # help save time by not having to execute the JSONEdit jar every step that is taken no mater if
    # the updating is redunant and doesnt change the state. 
# First cart below this line-----------------------------------------------
    if len(carts0) == 0 & lastKnown0:
	arg = 'SaigonSandwich0'
	os.system('java -jar JSONEdit.jar '+arg)
	lastKnown0 = False
    for (x, y, w, h) in carts0:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
	arg = 'SaigonSandwich1'
	os.system('java -jar JSONEdit.jar '+arg)
	lastKnown0 = True

    cv2.imshow('Video', frame)
	# Keep sending the update isAtLocation to true, false if not detected. 
	# Insert JSON editing script here (input params = arg) 
# Next cart below this line-------------------------------------------------
    if len(carts1) == 0 & lastKnown1:
	arg = 'Banzo0'
	os.system('java -jar JSONEdit.jar '+arg)
	lastKonwn1 = False
    for (x, y, w, h) in carts1:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
	arg = 'Banzo1'
	os.system('java -jar JSONEdit.jar '+arg)
	lastKnown1 = True

    cv2.imshow('Video', frame)
# Next cart below this line--------------------------------------------------
    if len(carts2) == 0 & lastKnown2:
	arg = 'BatterBrothers0'
	os.system('java -jar JSONEdit.jar '+arg)
	lastKonwn2 = False
    for (x, y, w, h) in carts1:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
	arg = 'BatterBrothers1'
	os.system('java -jar JSONEdit.jar '+arg)
	lastKnown2 = True

    cv2.imshow('Video', frame)
# Use the following as a template to add support for more detection units:
#    if len(carts1) == 0 & lastKnown1:
#	arg = 'HumanFace0'
#	os.system('java -jar JSONEdit.jar '+arg)
#	lastKonwn1 = False
#    for (x, y, w, h) in carts1:
#        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)
#	arg = 'HumanFace1'
#	os.system('java -jar JSONEdit.jar '+arg)
#	lastKnown1 = True


    # Display the resulting frame and update JSON on server
    cv2.imshow('Video', frame)
    os.system('./startSFTP.sh')

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# When everything is done, release the capture
video_capture.release()
cv2.destroyAllWindows()

