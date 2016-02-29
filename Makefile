SDK=$(shell cat local.properties | grep sdk-location | cut -d= -f2)

debug:
	ant debug
	ant installr

release:
	ant release
	jarsigner -verbose -keystore /home/echtler/media/docs/android-release.keystore bin/Timelapse-unsigned.apk android-release-key
	$(SDK)/tools/zipalign -f -v 4 bin/Timelapse-unsigned.apk bin/Timelapse-final.apk
	$(SDK)/platform-tools/adb install -r bin/Timelapse-final.apk

clean:
	ant clean

timelapse:
    ffmpeg -r 5 -i img%06d.jpg -vcodec libx264 time-lapse.mp4