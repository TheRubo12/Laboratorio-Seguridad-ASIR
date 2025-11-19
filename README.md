# 🛡️ Laboratorio de Ciberseguridad – IPTables | Snort | Tripwire | OpenVPN

Proyecto desarrollado durante el ciclo **ASIR** cuyo objetivo es desplegar un laboratorio de virtualización
orientado a la administración de sistemas y la ciberseguridad.

El entorno incluye:

- 3 máquinas virtuales en **VirtualBox**:
  - Kali Linux (VM-KL)
  - Metasploitable (VM-MT)
  - Windows 10 (VM-WIN)
- Red NAT personalizada `NET051 (192.168.10.0/24)`
- Seguridad perimetral con **IPTables**
- Detección de intrusiones con **Snort (IDS)**
- Control de integridad con **Tripwire**
- Implementación de una **VPN** completa con **OpenVPN + EasyRSA**

---

## 📌 Contenidos principales

### 1. Configuración del laboratorio

En el directorio `docs/` se incluye el informe original en PDF donde se documenta:

- Instalación e importación de las máquinas virtuales.
- Configuración de la red NAT NET051.
- Pruebas de conectividad entre las VMs y salida a Internet.

### 2. Seguridad perimetral con IPTables

En `config/iptables/iptables_rules.sh` se incluyen reglas de ejemplo:

- Política por defecto **DROP** en INPUT y FORWARD.
- Permitir tráfico de loopback.
- Permitir conexiones establecidas/relacionadas.
- Apertura controlada de puertos HTTP (80) y SSH (22) desde VM-WIN.
- Reglas de salida para DNS, HTTP y HTTPS.
- Ejemplo de bloqueo de dominios (UOC / YouTube) mediante IP y /etc/hosts.

> Estas reglas están pensadas para un entorno de LAB y deben revisarse antes de usarse en producción.

### 3. IDS – Detección de intrusiones con Snort

En `config/snort/local_rubo.rules` se añaden reglas personalizadas basadas en el informe:

- Detección de accesos SSH desde VM-WIN a VM-KL.
- Detección de accesos HTTP desde VM-WIN al servidor web.
- Detección de pings (ICMP) a VM-KL, incluyendo regla específica para VM-WIN.
- Detección de intentos de acceso a YouTube desde VM-KL.

Estas reglas se cargan desde `snort.lua` usando la directiva `include` (ver documentación de Snort).

### 4. Control de integridad con Tripwire

En `config/tripwire/twpol.txt` se incluye un ejemplo de política simplificada que:

- Supervisa directorios críticos (`/root`, `/etc/init.d`, `/etc/rc*.d`).
- Muestra cómo comentar rutas ruidosas para reducir falsos positivos.
- Sirve como base para personalizar una política adaptada al entorno real.

### 5. Implementación de VPN con OpenVPN

En `config/openvpn/server.conf` y `config/openvpn/client.conf` se incluyen configuraciones de ejemplo para:

- Servidor OpenVPN en Linux (VM-KL) usando:
  - `ca.crt`
  - `servidor-UOC.crt`
  - `servidor-UOC.key`
  - `ta.key` (tls-crypt)
- Cliente OpenVPN (Windows o Linux) utilizando:
  - Certificado de cliente `rvicentegil@uoc.edu.crt`
  - Clave `rvicentegil@uoc.edu.key`
  - La misma CA y `ta.key`.

En `scripts/make_config.sh` se muestra cómo generar un `.ovpn` unificado para el cliente a partir de una plantilla
y los ficheros de claves.

En `ovpn/rvicentegil@uoc.edu.ovpn` se incluye un ejemplo de configuración de cliente final.

---

## 🚀 Cómo usar este repositorio

1. Clonar o descargar el repositorio.
2. Revisar la documentación en `docs/Producto1.pdf`.
3. Adaptar las configuraciones de:
   - IPs de red.
   - Rutas a certificados.
   - Interfaces de red (`eth0`, `tun0`, etc.).
4. Aplicar las reglas IPTables en una máquina de laboratorio, nunca directamente en producción sin revisarlas.
5. Probar las reglas de Snort generando tráfico controlado (SSH, HTTP, ICMP).
6. Personalizar la política de Tripwire según los directorios de interés.
7. Configurar OpenVPN siguiendo los ejemplos y verificando la conexión desde un cliente.

---

## ⚠️ Aviso

Todo el contenido de este repositorio está orientado a **aprendizaje y laboratorio**.
No debe utilizarse sin adaptación ni revisión previa en entornos de producción.

---

## 📩 Contacto

Si quieres comentar sobre el proyecto, mejorar reglas IDS o intercambiar ideas sobre seguridad:

- LinkedIn: *(añade tu enlace aquí)*
