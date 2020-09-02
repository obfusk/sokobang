from pythonforandroid.recipe import PythonRecipe

class FlaskRecipe(PythonRecipe):
    version = '1.1.2'
    url = 'https://github.com/pallets/flask/archive/{version}.zip'
    depends = ['setuptools']
    python_depends = ['jinja2', 'werkzeug', 'markupsafe', 'itsdangerous', 'click']
    call_hostpython_via_targetpython = False
    install_in_hostpython = False

recipe = FlaskRecipe()

# FIXME
def _patch_webview():
    import subprocess
    file  = "pythonforandroid/bootstraps/webview/build/" \
          + "src/main/java/org/kivy/android/PythonActivity.java"
    sett  = " "*12 + "mWebView.getSettings()."
    zoomc = sett + "setBuiltInZoomControls(true);"
    zoomd = sett + "setDisplayZoomControls(false);"
    ext   = "\\n".join( " "*18 + x for x in """
      if(!(url.startsWith("file:") || url.startsWith("http://127.0.0.1:"))) {
        Intent i = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
        startActivity(i);
        return true;
      }
    """.splitlines()[1:-1] ).replace("/", "\\/")
    cmd   = """
      set -e
      if ! grep -q ZoomControls {file}; then
        sed '/setDomStorageEnabled/ s/$/\\n{zoomc}\\n{zoomd}/' -i {file}
        if ! grep -q ZoomControls {file}; then echo failed; exit 1; fi
        echo patched zoom
      fi
      if ! grep -qF android.net.Uri {file}; then
        sed '/import.*WebView;/ s/$/\\nimport android.net.Uri;/' -i {file}
        if ! grep -qF android.net.Uri {file}; then echo failed; exit 1; fi
        echo patched uri
      fi
      if ! grep -qF url.startsWith {file}; then
        sed '/shouldOverrideUrlLoading/ s/$/\\n{ext}/' -i {file}
        if ! grep -qF url.startsWith {file}; then echo failed; exit 1; fi
        echo patched load
      fi
    """.format(file = file, zoomc = zoomc, zoomd = zoomd, ext = ext)
    info("Patching webview ...")
    subprocess.run(cmd, shell = True, check = True)

_patch_webview()
