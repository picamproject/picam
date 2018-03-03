import guizero
import subprocess
import time
import os
from guizero import App, Text, PushButton, info
def tenninty():
    info("Recording...", "You are now recording...")
    os.system("raspivid -w 640 -h 480 -fps 90 -t 10000 -o 10s90fps.h264")
    info("Converting", "Converting your video. Please wait...")
    os.system("MP4Box -fps 90 -add 10s90fps.h264 10s90fps.mp4")
    info("Finished", "Your video is ready!")
def tenfourtynine():
    info("Recording...", "You are now recording...")
    os.system("raspivid -w 1296 -h 730 -fps 49 -t 10000 -o 10s49fps.h264")
    info("Converting", "Converting your video. Please wait...")
    os.system("MP4Box -fps 49 -add 10s49fps.h264 10s49fps.mp4")
    info("Finished", "Your video is ready!")
app = App(title="CamPi")
welcome_message = Text(app, text="CamPi")
update_text = PushButton(app, command=tenninty, text="90 FPS for 10 Sec")
update_text = PushButton(app, command=tenfourtynine, text="49 FPS for 10 Sec")
app.display()
