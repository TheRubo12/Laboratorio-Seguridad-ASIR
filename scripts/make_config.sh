#!/bin/bash
# Script para generar un archivo .ovpn unificado a partir de una plantilla y claves
# Uso: ./make_config.sh NOMBRE_CLIENTE

CLIENT="$1"
if [ -z "$CLIENT" ]; then
  echo "Uso: $0 NOMBRE_CLIENTE"
  exit 1
fi

BASE_DIR="/etc/openvpn/client/keys"
OUTPUT_DIR="/etc/openvpn/client/files"
TEMPLATE="/etc/openvpn/client/plantilla.conf"

mkdir -p "$OUTPUT_DIR"

OVPN_FILE="$OUTPUT_DIR/${CLIENT}.ovpn"

cp "$TEMPLATE" "$OVPN_FILE"

echo "<ca>" >> "$OVPN_FILE"
cat "$BASE_DIR/ca.crt" >> "$OVPN_FILE"
echo "</ca>" >> "$OVPN_FILE"

echo "<cert>" >> "$OVPN_FILE"
cat "$BASE_DIR/${CLIENT}.crt" >> "$OVPN_FILE"
echo "</cert>" >> "$OVPN_FILE"

echo "<key>" >> "$OVPN_FILE"
cat "$BASE_DIR/${CLIENT}.key" >> "$OVPN_FILE"
echo "</key>" >> "$OVPN_FILE"

echo "<tls-crypt>" >> "$OVPN_FILE"
cat "$BASE_DIR/ta.key" >> "$OVPN_FILE"
echo "</tls-crypt>" >> "$OVPN_FILE"

echo "Archivo generado: $OVPN_FILE"
