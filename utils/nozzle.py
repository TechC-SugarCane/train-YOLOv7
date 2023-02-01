import time
import sys
import Jetson.GPIO as GPIO

led_0 =  23
led_1 =  21

# def nozzle():

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD) 
#GPIO.setup(led_0, GPIO.OUT, initial=GPIO.HIGH)
GPIO.setup(led_0, GPIO.OUT)
GPIO.setup(led_1, GPIO.OUT)

try:
    print("start")
    # for _ in range(20):
    while True:
        # GPIOの出力を0にする（LEDが消灯する）
        GPIO.output(led_0, 0)
        GPIO.output(led_1, 0)
        time.sleep(1)

        GPIO.output(led_0, 1)
        GPIO.output(led_1, 1)
        time.sleep(2)

except:
    # GPIOの出力を0にする
    GPIO.output(led_0, 0)
    GPIO.output(led_1, 0)

finally:
    # GPIOの設定を初期化する
    GPIO.cleanup()
    print("stop")

