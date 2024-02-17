# Pertemuan 5: Sabtu, 17 Februari 2023

Saran untuk CLI Python: pake library "rich" 
Referensi: [Mas Andi](https://github.com/andirkh/financial-record)

Ekosistem Django https://djangopackages.org/ biar tinggal import-import aja

Untuk .gitignore di mac, tambahin manual ".DS_Store" dan ".nix-shell"

## Start MVC Boilerplate dari Django
1. Create folder dan `git init` untuk local git dulu
2. Initialize pdm project dulu `pdm init` dan lanjut dengan template
3. Akan generated file .gitignore juga, tambahin secara manual ".DS_Store" dan ".nix-shell"
4. Lanjut commit dan push ke remote repo
4. Init project django `pdm run django-admin startproject project-title`
5. Drag `manage.py` dan folder `project_title` di dalam project_title master folder, ke folder src
6. lanjut `pdm run src/manage.py runserver` untuk run dev mode
7. lanjut run di port 8000

## Apa maksud dari files di folder project?
### settings.py
- secret key -> untuk store secret key
- middleware -> security layer

### urls.py
- define basic routing di app django
- udah ada admin bawaan dari django
- generate uname dan pswd di django:
    - trigger migration untuk db.sqlite3: `pdm run src/manage.py migrate`
    - create user: `pdm run src/manage.py createsuperuser`
    - untuk create user lainnya, bisa lewat `localhost:8000/admin`, GUI bawaan dari django

### wsgi.py atau asgi.py - untuk prod deployment
ASGI -> Async
<br>WSGI -> Sync

Untuk deployment, bisa menggunakan [Granian - Rust HTTP server for Python](https://github.com/emmett-framework/granian) atau [Gunicorn - Python WSGI HTTP Server](https://gunicorn.org/)
Performance Granian lebih kenceng RPS-nya (requests per second) dibanding Python Based HTTP Server

Granian -> Python cosplaying jadi rust

## Run production dengan Granian:
- add granian ke pdm `pdm add granian`
- change dir ke root foldernya project `cd src`
- `prd run granian --interface wsgi project_title.wsgi:application`
