From ae01d0360143bf1a86e9a66b6e32e0ef0156b104 Mon Sep 17 00:00:00 2001
From: Tiararose Biezetta <92842340+tiararosebiezetta@users.noreply.github.com>
Date: Sun, 15 May 2022 08:56:44 +0700
Subject: [PATCH] Add web procfile and buildpack support (#1)

---
 .buildpacks      |  2 ++
 Aptfile          |  1 +
 Procfile         |  1 +
 app.json         | 14 ++++++++++++++
 clever.py        | 13 +++++++++++++
 requirements.txt |  2 ++
 start.sh         |  3 ++-
 7 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 .buildpacks
 create mode 100644 Aptfile
 create mode 100644 Procfile
 create mode 100644 app.json
 create mode 100644 clever.py

diff --git a/.buildpacks b/.buildpacks
new file mode 100644
index 00000000..29bda0ea
--- /dev/null
+++ b/.buildpacks
@@ -0,0 +1,2 @@
+https://github.com/Scalingo/apt-buildpack.git
+https://github.com/Scalingo/python-buildpack.git
diff --git a/Aptfile b/Aptfile
new file mode 100644
index 00000000..24e9674d
--- /dev/null
+++ b/Aptfile
@@ -0,0 +1 @@
+unzip
diff --git a/Procfile b/Procfile
new file mode 100644
index 00000000..3351d8cf
--- /dev/null
+++ b/Procfile
@@ -0,0 +1 @@
+web: bash start.sh
diff --git a/app.json b/app.json
new file mode 100644
index 00000000..886ef716
--- /dev/null
+++ b/app.json
@@ -0,0 +1,14 @@
+{
+  "name": "SearchX",
+  "description": "A simple Telegram Bot for searching data on Google Drive.",
+  "keywords": [
+    "telegram"
+  ],
+  "repository": "https://github.com/tiararosebiezetta/SearchX",
+  "stack": "container",
+  "env":{
+        "CONFIG_ENV_URL":{
+            "description":"Make a config file in github gist and paste the raw url here (check config_sample.env)"
+        }
+    }
+}
diff --git a/clever.py b/clever.py
new file mode 100644
index 00000000..f3d2ff75
--- /dev/null
+++ b/clever.py
@@ -0,0 +1,13 @@
+import os
+from flask import Flask, request
+from flask_restful import Resource, Api
+
+app = Flask(__name__)
+api = Api(app)
+
+class Greeting (Resource):
+    def get(self):
+        return 'Lazyleech bot is running'
+
+api.add_resource(Greeting, '/') # Route_1
+app.run(host='0.0.0.0', port=os.environ.get('PORT', 8080))
diff --git a/requirements.txt b/requirements.txt
index 1da984bf..5cd55832 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -9,3 +9,5 @@ python-telegram-bot
 requests
 telegraph
 tenacity
+flask
+flask_restful
diff --git a/start.sh b/start.sh
index 38e4b4c2..46db91ff 100644
--- a/start.sh
+++ b/start.sh
@@ -1 +1,2 @@
-python3 -m bot
\ No newline at end of file
+python3 clever.py &
+python3 -m bot
