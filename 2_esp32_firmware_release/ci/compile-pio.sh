#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e
shopt -s globstar # Make sure we are inside the Gitea workspace

apt-get update
apt-get install -y sudo python3.9-venv python3-pip

# Install PlatformIO CLI
export PATH=$PATH:/root/.platformio/penv/bin
curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py -o get-platformio.py
python3 get-platformio.py

# Install ESP32 platform
pio pkg install --platform "espressif32"

echo "################################"
echo "esps3"
pio run -e seeed_xiao_esp32c3


# Zielordner für firmware.bin
dir="bin/"

# Prüfen, ob der Ordner existiert
if [ ! -d "$dir" ]; then
  echo "Ordner existiert nicht. Erstelle Ordner..."
  mkdir -p "$dir"  
else
  echo "Ordner existiert bereits."
fi

cp .pio/build/seeed_xiao_esp32c3/firmware.bin "$dir/"
echo "firmware c3 wurde nach $dir verschoben."
mv bin/firmware.bin bin/firmware_esp32c3.bin
echo "firmware umbenannt."

echo "################################"
echo "esps3"
pio run -e seeed_xiao_esp32s3


cp .pio/build/seeed_xiao_esp32s3/firmware.bin "$dir/"
echo "firmware s3 wurde nach $dir verschoben."
mv bin/firmware.bin bin/firmware_esp32s3.bin
echo "firmware umbenannt."
