"""Read integrated ESP32 telemetry. Does not activate motors or audio."""
import sys, time, json
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / '.tools' / 'microphone-monitor-deps'))
import serial

port = sys.argv[1] if len(sys.argv) > 1 else 'COM14'
def emit(**value):
    print(json.dumps(value), flush=True)

while True:
    connection = None
    try:
        connection = serial.Serial()
        connection.port, connection.baudrate, connection.timeout = port, 115200, .2
        connection.dtr = connection.rts = False
        connection.open()
        emit(connected=True, port=port)
        next_query = 0
        while True:
            if time.monotonic() >= next_query:
                connection.write(b'?')
                next_query = time.monotonic() + 2
            line = connection.readline().decode('utf-8', errors='replace').strip()
            if line:
                emit(line=line[:600])
    except (serial.SerialException, OSError):
        emit(connected=False, error='ESP32 serial unavailable. Check USB or close another serial monitor.', port=port)
        time.sleep(3)
    finally:
        if connection and connection.is_open:
            connection.close()
