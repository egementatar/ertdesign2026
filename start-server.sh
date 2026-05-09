#!/bin/bash
echo "======================================"
echo "  ERT Design - Local Server"
echo "======================================"
echo ""
echo "Sunucu başlatılıyor..."
echo "Tarayıcınızda açın: http://localhost:8080"
echo "Admin panel:        http://localhost:8080/admin.html"
echo ""
echo "Durdurmak için: CTRL+C"
echo "======================================"
cd /home/loufy/Masaüstü/files
python3 -m http.server 8080
