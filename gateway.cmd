@echo off
rem OpenClaw Gateway (v2026.3.2)
set "TMPDIR=C:\Users\Administrator\AppData\Local\Temp"
set "PATH=D:\app\ShadowBot;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\dotnet\;C:\Program Files (x86)\dotnet\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;D:\AOMEI\AOMEI Backupper\7.4.2;D:\app\Git\cmd;C:\PythonScript;D:\Python 3\Scripts\;D:\Python 3\;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;D:\app\Microsoft VS Code\bin;C:\Program Files (x86)\Nmap;C:\Users\Administrator\AppData\Local\Programs\Ollama;C:\ffmpeg\bin;D:\app\Graphviz\bin;C:\Program Files\nodejs\;D:\app\ShadowBot;?C:\PythonScript;D:\Python 3\Scripts\;D:\Python 3\;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;D:\app\Microsoft VS Code\bin;C:\Program Files (x86)\Nmap;C:\Users\Administrator\AppData\Local\Programs\Ollama;D:\app\Graphviz\bin;D:\app\DataGrip 2025.2.4\bin;C:\Users\Administrator\AppData\Roaming\npm"
set "HTTP_PROXY=http://127.0.0.1:7890"
set "HTTPS_PROXY=http://127.0.0.1:7890"
set "http_proxy=http://127.0.0.1:7890"
set "https_proxy=http://127.0.0.1:7890"
set "OPENCLAW_GATEWAY_PORT=18789"
set "OPENCLAW_GATEWAY_TOKEN=3f55d09684d9f616a0e21fc5a44069a6fdd505e4974bc498"
set "OPENCLAW_SYSTEMD_UNIT=openclaw-gateway.service"
set "OPENCLAW_SERVICE_MARKER=openclaw"
set "OPENCLAW_SERVICE_KIND=gateway"
set "OPENCLAW_SERVICE_VERSION=2026.3.2"
"C:\Program Files\nodejs\node.exe" C:\Users\Administrator\AppData\Roaming\npm\node_modules\openclaw\dist\index.js gateway --port 18789
